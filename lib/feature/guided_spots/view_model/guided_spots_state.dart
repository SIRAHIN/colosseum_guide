import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';

class GuidedSpotsState {
  final bool isLoading;
  final List<TourModel> tours;

  GuidedSpotsState({
    required this.tours,
    this.isLoading = false,
  });

  GuidedSpotsState copyWith({
    bool? isLoading,
    List<TourModel>? tours,
  }) {
    return GuidedSpotsState(
      isLoading: isLoading ?? this.isLoading,
      tours: tours ?? this.tours,
    );
  }
}