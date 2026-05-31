import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_model.freezed.dart';
part 'guide_model.g.dart';

@freezed
class GuideModelData with _$GuideModelData {
  const factory GuideModelData({
    required List<TourModel> tours,
  }) = _GuideModelData;

  factory GuideModelData.fromJson(Map<String, dynamic> json) =>
      _$GuideModelDataFromJson(json);
}

@freezed
class TourModel with _$TourModel {
  const factory TourModel({
    required String id,
    required String title,
    required String subtitle,
    required String description,
    required String coverImage,
    required int durationMinutes,
    required List<TourPointModel> points,
  }) = _TourModel;

  factory TourModel.fromJson(Map<String, dynamic> json) =>
      _$TourModelFromJson(json);
}

@freezed
class TourPointModel with _$TourPointModel {
  const factory TourPointModel({
    required String id,
    required String title,
    required String subtitle,
    required String description,
    required String panoramaImage,
    required String narrationAudio,
    required double yaw,
    required double pitch,
    required List<String> connections,
    required List<HotspotModel> hotspots,
  }) = _TourPointModel;

  factory TourPointModel.fromJson(Map<String, dynamic> json) =>
      _$TourPointModelFromJson(json);
}

@freezed
class HotspotModel with _$HotspotModel {
  const factory HotspotModel({
    required String id,
    required String title,
    required String description,
    required double yaw,
    required double pitch,
    required String icon,
  }) = _HotspotModel;

  factory HotspotModel.fromJson(Map<String, dynamic> json) =>
      _$HotspotModelFromJson(json);
}