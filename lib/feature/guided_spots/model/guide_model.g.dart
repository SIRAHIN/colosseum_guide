// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuideModelDataImpl _$$GuideModelDataImplFromJson(Map<String, dynamic> json) =>
    _$GuideModelDataImpl(
      tours: (json['tours'] as List<dynamic>)
          .map((e) => TourModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GuideModelDataImplToJson(
        _$GuideModelDataImpl instance) =>
    <String, dynamic>{
      'tours': instance.tours,
    };

_$TourModelImpl _$$TourModelImplFromJson(Map<String, dynamic> json) =>
    _$TourModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      coverImage: json['coverImage'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      points: (json['points'] as List<dynamic>)
          .map((e) => TourPointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TourModelImplToJson(_$TourModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'coverImage': instance.coverImage,
      'durationMinutes': instance.durationMinutes,
      'points': instance.points,
    };

_$TourPointModelImpl _$$TourPointModelImplFromJson(Map<String, dynamic> json) =>
    _$TourPointModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      panoramaImage: json['panoramaImage'] as String,
      narrationAudio: json['narrationAudio'] as String,
      yaw: (json['yaw'] as num).toDouble(),
      pitch: (json['pitch'] as num).toDouble(),
      connections: (json['connections'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hotspots: (json['hotspots'] as List<dynamic>)
          .map((e) => HotspotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TourPointModelImplToJson(
        _$TourPointModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'panoramaImage': instance.panoramaImage,
      'narrationAudio': instance.narrationAudio,
      'yaw': instance.yaw,
      'pitch': instance.pitch,
      'connections': instance.connections,
      'hotspots': instance.hotspots,
    };

_$HotspotModelImpl _$$HotspotModelImplFromJson(Map<String, dynamic> json) =>
    _$HotspotModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      yaw: (json['yaw'] as num).toDouble(),
      pitch: (json['pitch'] as num).toDouble(),
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$HotspotModelImplToJson(_$HotspotModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'yaw': instance.yaw,
      'pitch': instance.pitch,
      'icon': instance.icon,
    };
