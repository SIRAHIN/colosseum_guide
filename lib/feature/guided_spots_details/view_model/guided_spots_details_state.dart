import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';

class GuidedSpotsDetailsState {
  final bool audioLoaded;
  final bool loading;
  final int currentIndex;
  final List<TourPointModel> tourPoints;

  GuidedSpotsDetailsState({
    this.audioLoaded = false,
    this.loading = true,
    this.currentIndex = 0,
    this.tourPoints = const [],
  });

  GuidedSpotsDetailsState copyWith({
    bool? audioLoaded,
    bool? loading,
    int? currentIndex,
    List<TourPointModel>? tourPoints,
  }) {
    return GuidedSpotsDetailsState(
      audioLoaded: audioLoaded ?? this.audioLoaded,
      loading: loading ?? this.loading,
      currentIndex: currentIndex ?? this.currentIndex,
      tourPoints: tourPoints ?? this.tourPoints,
    );
  }
}
