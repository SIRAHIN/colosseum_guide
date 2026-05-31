import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/view_model/guided_spots_details_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'guided_spots_details_view_model.g.dart'; // Run build_runner to generate this file

@riverpod
class GuidedSpotsDetailsViewModel extends _$GuidedSpotsDetailsViewModel {
  late AudioPlayer audioPlayer;

  @override
  GuidedSpotsDetailsState build(List<TourPointModel> tourPoints) {
    audioPlayer = AudioPlayer();
    ref.onDispose(() => audioPlayer.dispose());
    return GuidedSpotsDetailsState(
      audioLoaded: false,
      loading: true,
      currentIndex: 0,
      tourPoints: tourPoints,
    );
  }

  // Load audio for the current stop
  Future<void> loadAudio() async {
    if (state.tourPoints.isEmpty) return;
    state = state.copyWith(audioLoaded: false);
    try {
      await audioPlayer.setAsset(
        state.tourPoints[state.currentIndex].narrationAudio,
      );
      state = state.copyWith(audioLoaded: true);
    } catch (_) {
      state = state.copyWith(audioLoaded: false);
    }
    state = state.copyWith(loading: false);
  }

  // Navigate to a specific stop by index
  void goToStop(int index) {
    if (index < 0 || index >= state.tourPoints.length) return;
    audioPlayer.stop();
    state = state.copyWith(currentIndex: index);
    loadAudio();
  }
}

