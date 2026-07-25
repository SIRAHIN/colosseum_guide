import 'dart:async';

import 'package:colosseum_guide/core/services/audio_download_service.dart';
import 'package:colosseum_guide/core/services/onboarding_cache.dart';
import 'package:colosseum_guide/feature/download_audio/view_model/download_audio_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadAudioViewModel extends StateNotifier<DownloadAudioState> {
  DownloadAudioViewModel(this._service, this._onboarding)
      : super(const DownloadAudioState()) {
    _checkExisting();
  }

  final AudioDownloadService _service;
  final OnboardingCache _onboarding;
  CancelToken? _cancelToken;

  Future<void> _checkExisting() async {
    final count = await _service.downloadedCount();
    final total = AudioDownloadService.trackDriveIds.length;
    if (count == total) {
      state = DownloadAudioState(
        status: DownloadStatus.completed,
        progress: 1.0,
        completedFiles: total,
        totalFiles: total,
      );
      await _onboarding.setAudioDownloaded(true);
    } else if (count > 0) {
      state = DownloadAudioState(
        completedFiles: count,
        progress: count / total,
        totalFiles: total,
      );
    }
  }

  Future<void> startDownload() async {
    if (state.isDownloading) return;

    _cancelToken = CancelToken();
    state = DownloadAudioState(
      status: DownloadStatus.downloading,
      totalFiles: AudioDownloadService.trackDriveIds.length,
    );

    try {
      await for (final p in _service.downloadAll(cancelToken: _cancelToken)) {
        state = DownloadAudioState(
          status: DownloadStatus.downloading,
          progress: p.overallProgress,
          currentFile: p.currentFile,
          completedFiles: p.fileIndex + 1,
          totalFiles: p.totalFiles,
        );
      }
      state = state.copyWith(
        status: DownloadStatus.completed,
        progress: 1.0,
      );
      await _onboarding.setAudioDownloaded(true);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        state = state.copyWith(status: DownloadStatus.cancelled);
      } else {
        state = state.copyWith(
          status: DownloadStatus.error,
          errorMessage: e.message ?? 'Download failed',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: DownloadStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void cancel() {
    _cancelToken?.cancel('User cancelled download');
    state = state.copyWith(status: DownloadStatus.cancelled);
  }

  // Workaround for analyzer warnings about accessing `state` from outside.
  // ignore: invalid_use_of_protected_member
  DownloadAudioState get currentState => state;
}

final audioDownloadServiceProvider = Provider<AudioDownloadService>((ref) {
  return AudioDownloadService();
});

final downloadAudioViewModelProvider =
    StateNotifierProvider<DownloadAudioViewModel, DownloadAudioState>((ref) {
  return DownloadAudioViewModel(
    ref.watch(audioDownloadServiceProvider),
    ref.watch(onboardingCacheProvider),
  );
});
