import 'package:colosseum_guide/core/services/audio_download_service.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/view_model/guided_spots_details_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class GuidedSpotsDetailsViewModel
    extends StateNotifier<GuidedSpotsDetailsState> {
  GuidedSpotsDetailsViewModel(this.tourPoints, this._downloadService)
      : super(GuidedSpotsDetailsState(
          loading: true,
          tourPoints: tourPoints,
        )) {
    audioPlayer = AudioPlayer();
  }

  final List<TourPointModel> tourPoints;
  final AudioDownloadService _downloadService;

  late final AudioPlayer audioPlayer;

  Future<void> loadAudio() async {
    if (state.tourPoints.isEmpty) {
      state = state.copyWith(loading: false);
      return;
    }
    state = state.copyWith(audioLoaded: false);
    try {
      final point = state.tourPoints[state.currentIndex];
      final filename = point.narrationAudio.split('/').last;

      if (await _downloadService.isDownloaded(filename)) {
        final path = await _downloadService.localPath(filename);
        await audioPlayer.setFilePath(path);
      } else {
        await audioPlayer.setAsset(point.narrationAudio);
      }
      state = state.copyWith(audioLoaded: true);
    } catch (_) {
      state = state.copyWith(audioLoaded: false);
    }
    state = state.copyWith(loading: false);
  }

  void goToStop(int index) {
    if (index < 0 || index >= state.tourPoints.length) return;
    audioPlayer.stop();
    state = state.copyWith(currentIndex: index);
    loadAudio();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

final _downloadServiceProvider = Provider<AudioDownloadService>((ref) {
  return AudioDownloadService();
});

final guidedSpotsDetailsViewModelProvider = StateNotifierProvider.family<
    GuidedSpotsDetailsViewModel,
    GuidedSpotsDetailsState,
    List<TourPointModel>>((ref, points) {
  return GuidedSpotsDetailsViewModel(
    points,
    ref.watch(_downloadServiceProvider),
  );
});
