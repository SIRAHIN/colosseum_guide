import 'package:flutter/foundation.dart';

enum DownloadStatus { idle, downloading, completed, error, cancelled }

@immutable
class DownloadAudioState {
  final DownloadStatus status;
  final double progress; // 0.0 – 1.0
  final String currentFile;
  final int completedFiles;
  final int totalFiles;
  final String? errorMessage;

  const DownloadAudioState({
    this.status = DownloadStatus.idle,
    this.progress = 0.0,
    this.currentFile = '',
    this.completedFiles = 0,
    this.totalFiles = 15,
    this.errorMessage,
  });

  bool get isDownloading => status == DownloadStatus.downloading;
  bool get isCompleted => status == DownloadStatus.completed;
  bool get hasError => status == DownloadStatus.error;

  DownloadAudioState copyWith({
    DownloadStatus? status,
    double? progress,
    String? currentFile,
    int? completedFiles,
    int? totalFiles,
    String? errorMessage,
  }) {
    return DownloadAudioState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      currentFile: currentFile ?? this.currentFile,
      completedFiles: completedFiles ?? this.completedFiles,
      totalFiles: totalFiles ?? this.totalFiles,
      errorMessage: errorMessage,
    );
  }
}
