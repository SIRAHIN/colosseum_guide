import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

/// Downloads audio tracks from Google Drive to app documents directory.
///
/// Files are stored at `<app_docs>/audio/Track_XX.mp3`.
class AudioDownloadService {
  AudioDownloadService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// Google Drive file IDs for the 15 audio tracks (Track_00 .. Track_14).
  static const Map<String, String> trackDriveIds = {
    'Track_00.mp3': '1Gk5iRU2UQ6LwIKJcpFJvyttqE9opHe9Q',
    'Track_01.mp3': '1piHMYtdWGwpo-bGptpwEgskBvKkf9lQB',
    'Track_02.mp3': '16ZvRnRUQXZ13Ppr7VHekFEwRUDWA-76a',
    'Track_03.mp3': '1LngyPnrdlWbWmxZsxepvm2kAJek4MmfN',
    'Track_04.mp3': '1EL17lvIEMfyaVyo2WW6SdReS6JKdobhB',
    'Track_05.mp3': '1D0shWDqqwgEl52o9Y-aneKa0iUMKg4G-',
    'Track_06.mp3': '1-4yzZRwX5g52TJzr47B8gDe_fyHMWvVu',
    'Track_07.mp3': '14KaJWTjy0m68Mr_q8fxTBsWLuy-NSQfN',
    'Track_08.mp3': '1LS1-8INR13aIlpUqOIBjdb_1ja7_ZeKk',
    'Track_09.mp3': '1aq-V79Lq-gQiJ3YtGPOxf-_eSSxN1XRc',
    'Track_10.mp3': '1XU8atPBoSWv3xRxnPFESwOxL-8Jlxfb3',
    'Track_11.mp3': '10nD22X2137QbdjNVqqXFy-2HtdhPB96b',
    'Track_12.mp3': '1Fa5fKXaIwPK4HZP_I9XvOFzHKyLv1FqO',
    'Track_13.mp3': '1FJXvuwGUHDGuTp0kVHOZDoc8tJC4SrpB',
    'Track_14.mp3': '1IaDmOs3gfgo_Mxam-KT1cQjJPvFD8Ri5',
  };

  static List<String> get allTracks => trackDriveIds.keys.toList();

  String _driveUrl(String fileId) =>
      'https://drive.usercontent.google.com/download?id=$fileId&export=download&confirm=t';

  Future<String> localPath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/audio/$filename';
  }

  bool isDownloadedSync(String filename) {
    // Synchronous check using cached path — call after [localPath] once.
    // For initial check use [isDownloaded].
    throw UnimplementedError('Use isDownloaded()');
  }

  Future<bool> isDownloaded(String filename) async {
    return File(await localPath(filename)).existsSync();
  }

  Future<int> downloadedCount() async {
    var count = 0;
    for (final f in trackDriveIds.keys) {
      if (File(await localPath(f)).existsSync()) count++;
    }
    return count;
  }

  Future<bool> isAllDownloaded() async {
    for (final f in trackDriveIds.keys) {
      if (!File(await localPath(f)).existsSync()) return false;
    }
    return true;
  }

  /// Downloads a single file. Throws on failure.
  Stream<double> downloadFile(
    String filename, {
    void Function(int received, int total)? onProgress,
    CancelToken? cancelToken,
  }) async* {
    final fileId = trackDriveIds[filename];
    if (fileId == null) throw ArgumentError('Unknown track: $filename');

    final savePath = await localPath(filename);
    final file = File(savePath);
    await file.parent.create(recursive: true);

    // Skip if already downloaded.
    if (file.existsSync() && file.lengthSync() > 0) {
      yield 1.0;
      return;
    }

    await _dio.download(
      _driveUrl(fileId),
      savePath,
      onReceiveProgress: onProgress,
      cancelToken: cancelToken,
      options: Options(
        followRedirects: true,
        maxRedirects: 5,
        receiveTimeout: const Duration(minutes: 5),
      ),
    );
    yield 1.0;
  }

  /// Downloads all tracks sequentially. Yields overall progress 0.0–1.0.
  Stream<DownloadProgress> downloadAll({
    void Function(String currentFile)? onFileStart,
    CancelToken? cancelToken,
  }) async* {
    final total = trackDriveIds.length;
    var completed = 0;

    for (final filename in trackDriveIds.keys) {
      if (cancelToken?.isCancelled ?? false) return;

      final file = File(await localPath(filename));

      if (file.existsSync() && file.lengthSync() > 0) {
        completed++;
        yield DownloadProgress(
          currentFile: filename,
          fileIndex: completed - 1,
          totalFiles: total,
          overallProgress: completed / total,
          fileProgress: 1.0,
        );
        continue;
      }

      onFileStart?.call(filename);
      await file.parent.create(recursive: true);

      var fileProgress = 0.0;
      try {
        await _dio.download(
          _driveUrl(trackDriveIds[filename]!),
          file.path,
          onReceiveProgress: (received, totalBytes) {
            if (totalBytes > 0) {
              fileProgress = received / totalBytes;
            }
          },
          cancelToken: cancelToken,
          options: Options(
            followRedirects: true,
            maxRedirects: 5,
            receiveTimeout: const Duration(minutes: 5),
          ),
        );
        fileProgress = 1.0;
      } catch (e) {
        // Clean up partial file.
        if (file.existsSync()) file.deleteSync();
        rethrow;
      }

      completed++;
      yield DownloadProgress(
        currentFile: filename,
        fileIndex: completed - 1,
        totalFiles: total,
        overallProgress: completed / total,
        fileProgress: fileProgress,
      );
    }
  }

  Future<void> deleteAll() async {
    for (final f in trackDriveIds.keys) {
      final path = await localPath(f);
      final file = File(path);
      if (file.existsSync()) file.deleteSync();
    }
  }
}

class DownloadProgress {
  final String currentFile;
  final int fileIndex;
  final int totalFiles;
  final double overallProgress;
  final double fileProgress;

  const DownloadProgress({
    required this.currentFile,
    required this.fileIndex,
    required this.totalFiles,
    required this.overallProgress,
    required this.fileProgress,
  });
}
