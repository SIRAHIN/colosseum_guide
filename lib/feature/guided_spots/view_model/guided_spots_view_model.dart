import 'package:colosseum_guide/core/data/guide_data.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots/view_model/guided_spots_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuidedSpotsViewModel extends Notifier<GuidedSpotsState> {
  @override
  GuidedSpotsState build() {
    List<TourModel> tours = GuideModelData.fromJson(guideData).tours;
    return GuidedSpotsState(isLoading: false, tours: tours);
  }
}

final guidedSpotsViewModelProvider = NotifierProvider<GuidedSpotsViewModel, GuidedSpotsState>(
  () => GuidedSpotsViewModel(),
);