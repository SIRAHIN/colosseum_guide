// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guide_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GuideModelData _$GuideModelDataFromJson(Map<String, dynamic> json) {
  return _GuideModelData.fromJson(json);
}

/// @nodoc
mixin _$GuideModelData {
  List<TourModel> get tours => throw _privateConstructorUsedError;

  /// Serializes this GuideModelData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuideModelData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuideModelDataCopyWith<GuideModelData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuideModelDataCopyWith<$Res> {
  factory $GuideModelDataCopyWith(
    GuideModelData value,
    $Res Function(GuideModelData) then,
  ) = _$GuideModelDataCopyWithImpl<$Res, GuideModelData>;
  @useResult
  $Res call({List<TourModel> tours});
}

/// @nodoc
class _$GuideModelDataCopyWithImpl<$Res, $Val extends GuideModelData>
    implements $GuideModelDataCopyWith<$Res> {
  _$GuideModelDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuideModelData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tours = null}) {
    return _then(
      _value.copyWith(
            tours: null == tours
                ? _value.tours
                : tours // ignore: cast_nullable_to_non_nullable
                      as List<TourModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GuideModelDataImplCopyWith<$Res>
    implements $GuideModelDataCopyWith<$Res> {
  factory _$$GuideModelDataImplCopyWith(
    _$GuideModelDataImpl value,
    $Res Function(_$GuideModelDataImpl) then,
  ) = __$$GuideModelDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TourModel> tours});
}

/// @nodoc
class __$$GuideModelDataImplCopyWithImpl<$Res>
    extends _$GuideModelDataCopyWithImpl<$Res, _$GuideModelDataImpl>
    implements _$$GuideModelDataImplCopyWith<$Res> {
  __$$GuideModelDataImplCopyWithImpl(
    _$GuideModelDataImpl _value,
    $Res Function(_$GuideModelDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuideModelData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tours = null}) {
    return _then(
      _$GuideModelDataImpl(
        tours: null == tours
            ? _value._tours
            : tours // ignore: cast_nullable_to_non_nullable
                  as List<TourModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GuideModelDataImpl implements _GuideModelData {
  const _$GuideModelDataImpl({required final List<TourModel> tours})
    : _tours = tours;

  factory _$GuideModelDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuideModelDataImplFromJson(json);

  final List<TourModel> _tours;
  @override
  List<TourModel> get tours {
    if (_tours is EqualUnmodifiableListView) return _tours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tours);
  }

  @override
  String toString() {
    return 'GuideModelData(tours: $tours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuideModelDataImpl &&
            const DeepCollectionEquality().equals(other._tours, _tours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tours));

  /// Create a copy of GuideModelData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuideModelDataImplCopyWith<_$GuideModelDataImpl> get copyWith =>
      __$$GuideModelDataImplCopyWithImpl<_$GuideModelDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GuideModelDataImplToJson(this);
  }
}

abstract class _GuideModelData implements GuideModelData {
  const factory _GuideModelData({required final List<TourModel> tours}) =
      _$GuideModelDataImpl;

  factory _GuideModelData.fromJson(Map<String, dynamic> json) =
      _$GuideModelDataImpl.fromJson;

  @override
  List<TourModel> get tours;

  /// Create a copy of GuideModelData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuideModelDataImplCopyWith<_$GuideModelDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TourModel _$TourModelFromJson(Map<String, dynamic> json) {
  return _TourModel.fromJson(json);
}

/// @nodoc
mixin _$TourModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get coverImage => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  List<TourPointModel> get points => throw _privateConstructorUsedError;

  /// Serializes this TourModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TourModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourModelCopyWith<TourModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourModelCopyWith<$Res> {
  factory $TourModelCopyWith(TourModel value, $Res Function(TourModel) then) =
      _$TourModelCopyWithImpl<$Res, TourModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String description,
    String coverImage,
    int durationMinutes,
    List<TourPointModel> points,
  });
}

/// @nodoc
class _$TourModelCopyWithImpl<$Res, $Val extends TourModel>
    implements $TourModelCopyWith<$Res> {
  _$TourModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? coverImage = null,
    Object? durationMinutes = null,
    Object? points = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            coverImage: null == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as List<TourPointModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TourModelImplCopyWith<$Res>
    implements $TourModelCopyWith<$Res> {
  factory _$$TourModelImplCopyWith(
    _$TourModelImpl value,
    $Res Function(_$TourModelImpl) then,
  ) = __$$TourModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String description,
    String coverImage,
    int durationMinutes,
    List<TourPointModel> points,
  });
}

/// @nodoc
class __$$TourModelImplCopyWithImpl<$Res>
    extends _$TourModelCopyWithImpl<$Res, _$TourModelImpl>
    implements _$$TourModelImplCopyWith<$Res> {
  __$$TourModelImplCopyWithImpl(
    _$TourModelImpl _value,
    $Res Function(_$TourModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TourModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? coverImage = null,
    Object? durationMinutes = null,
    Object? points = null,
  }) {
    return _then(
      _$TourModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        coverImage: null == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        points: null == points
            ? _value._points
            : points // ignore: cast_nullable_to_non_nullable
                  as List<TourPointModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TourModelImpl implements _TourModel {
  const _$TourModelImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coverImage,
    required this.durationMinutes,
    required final List<TourPointModel> points,
  }) : _points = points;

  factory _$TourModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TourModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String description;
  @override
  final String coverImage;
  @override
  final int durationMinutes;
  final List<TourPointModel> _points;
  @override
  List<TourPointModel> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  String toString() {
    return 'TourModel(id: $id, title: $title, subtitle: $subtitle, description: $description, coverImage: $coverImage, durationMinutes: $durationMinutes, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    description,
    coverImage,
    durationMinutes,
    const DeepCollectionEquality().hash(_points),
  );

  /// Create a copy of TourModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourModelImplCopyWith<_$TourModelImpl> get copyWith =>
      __$$TourModelImplCopyWithImpl<_$TourModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TourModelImplToJson(this);
  }
}

abstract class _TourModel implements TourModel {
  const factory _TourModel({
    required final String id,
    required final String title,
    required final String subtitle,
    required final String description,
    required final String coverImage,
    required final int durationMinutes,
    required final List<TourPointModel> points,
  }) = _$TourModelImpl;

  factory _TourModel.fromJson(Map<String, dynamic> json) =
      _$TourModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get description;
  @override
  String get coverImage;
  @override
  int get durationMinutes;
  @override
  List<TourPointModel> get points;

  /// Create a copy of TourModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourModelImplCopyWith<_$TourModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TourPointModel _$TourPointModelFromJson(Map<String, dynamic> json) {
  return _TourPointModel.fromJson(json);
}

/// @nodoc
mixin _$TourPointModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get panoramaImage => throw _privateConstructorUsedError;
  String get narrationAudio => throw _privateConstructorUsedError;
  double get yaw => throw _privateConstructorUsedError;
  double get pitch => throw _privateConstructorUsedError;
  List<String> get connections => throw _privateConstructorUsedError;
  List<HotspotModel> get hotspots => throw _privateConstructorUsedError;

  /// Serializes this TourPointModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TourPointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourPointModelCopyWith<TourPointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourPointModelCopyWith<$Res> {
  factory $TourPointModelCopyWith(
    TourPointModel value,
    $Res Function(TourPointModel) then,
  ) = _$TourPointModelCopyWithImpl<$Res, TourPointModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String description,
    String panoramaImage,
    String narrationAudio,
    double yaw,
    double pitch,
    List<String> connections,
    List<HotspotModel> hotspots,
  });
}

/// @nodoc
class _$TourPointModelCopyWithImpl<$Res, $Val extends TourPointModel>
    implements $TourPointModelCopyWith<$Res> {
  _$TourPointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourPointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? panoramaImage = null,
    Object? narrationAudio = null,
    Object? yaw = null,
    Object? pitch = null,
    Object? connections = null,
    Object? hotspots = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            panoramaImage: null == panoramaImage
                ? _value.panoramaImage
                : panoramaImage // ignore: cast_nullable_to_non_nullable
                      as String,
            narrationAudio: null == narrationAudio
                ? _value.narrationAudio
                : narrationAudio // ignore: cast_nullable_to_non_nullable
                      as String,
            yaw: null == yaw
                ? _value.yaw
                : yaw // ignore: cast_nullable_to_non_nullable
                      as double,
            pitch: null == pitch
                ? _value.pitch
                : pitch // ignore: cast_nullable_to_non_nullable
                      as double,
            connections: null == connections
                ? _value.connections
                : connections // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            hotspots: null == hotspots
                ? _value.hotspots
                : hotspots // ignore: cast_nullable_to_non_nullable
                      as List<HotspotModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TourPointModelImplCopyWith<$Res>
    implements $TourPointModelCopyWith<$Res> {
  factory _$$TourPointModelImplCopyWith(
    _$TourPointModelImpl value,
    $Res Function(_$TourPointModelImpl) then,
  ) = __$$TourPointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String description,
    String panoramaImage,
    String narrationAudio,
    double yaw,
    double pitch,
    List<String> connections,
    List<HotspotModel> hotspots,
  });
}

/// @nodoc
class __$$TourPointModelImplCopyWithImpl<$Res>
    extends _$TourPointModelCopyWithImpl<$Res, _$TourPointModelImpl>
    implements _$$TourPointModelImplCopyWith<$Res> {
  __$$TourPointModelImplCopyWithImpl(
    _$TourPointModelImpl _value,
    $Res Function(_$TourPointModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TourPointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? panoramaImage = null,
    Object? narrationAudio = null,
    Object? yaw = null,
    Object? pitch = null,
    Object? connections = null,
    Object? hotspots = null,
  }) {
    return _then(
      _$TourPointModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        panoramaImage: null == panoramaImage
            ? _value.panoramaImage
            : panoramaImage // ignore: cast_nullable_to_non_nullable
                  as String,
        narrationAudio: null == narrationAudio
            ? _value.narrationAudio
            : narrationAudio // ignore: cast_nullable_to_non_nullable
                  as String,
        yaw: null == yaw
            ? _value.yaw
            : yaw // ignore: cast_nullable_to_non_nullable
                  as double,
        pitch: null == pitch
            ? _value.pitch
            : pitch // ignore: cast_nullable_to_non_nullable
                  as double,
        connections: null == connections
            ? _value._connections
            : connections // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        hotspots: null == hotspots
            ? _value._hotspots
            : hotspots // ignore: cast_nullable_to_non_nullable
                  as List<HotspotModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TourPointModelImpl implements _TourPointModel {
  const _$TourPointModelImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.panoramaImage,
    required this.narrationAudio,
    required this.yaw,
    required this.pitch,
    required final List<String> connections,
    required final List<HotspotModel> hotspots,
  }) : _connections = connections,
       _hotspots = hotspots;

  factory _$TourPointModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TourPointModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String description;
  @override
  final String panoramaImage;
  @override
  final String narrationAudio;
  @override
  final double yaw;
  @override
  final double pitch;
  final List<String> _connections;
  @override
  List<String> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  final List<HotspotModel> _hotspots;
  @override
  List<HotspotModel> get hotspots {
    if (_hotspots is EqualUnmodifiableListView) return _hotspots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hotspots);
  }

  @override
  String toString() {
    return 'TourPointModel(id: $id, title: $title, subtitle: $subtitle, description: $description, panoramaImage: $panoramaImage, narrationAudio: $narrationAudio, yaw: $yaw, pitch: $pitch, connections: $connections, hotspots: $hotspots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourPointModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.panoramaImage, panoramaImage) ||
                other.panoramaImage == panoramaImage) &&
            (identical(other.narrationAudio, narrationAudio) ||
                other.narrationAudio == narrationAudio) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            const DeepCollectionEquality().equals(
              other._connections,
              _connections,
            ) &&
            const DeepCollectionEquality().equals(other._hotspots, _hotspots));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    description,
    panoramaImage,
    narrationAudio,
    yaw,
    pitch,
    const DeepCollectionEquality().hash(_connections),
    const DeepCollectionEquality().hash(_hotspots),
  );

  /// Create a copy of TourPointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourPointModelImplCopyWith<_$TourPointModelImpl> get copyWith =>
      __$$TourPointModelImplCopyWithImpl<_$TourPointModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TourPointModelImplToJson(this);
  }
}

abstract class _TourPointModel implements TourPointModel {
  const factory _TourPointModel({
    required final String id,
    required final String title,
    required final String subtitle,
    required final String description,
    required final String panoramaImage,
    required final String narrationAudio,
    required final double yaw,
    required final double pitch,
    required final List<String> connections,
    required final List<HotspotModel> hotspots,
  }) = _$TourPointModelImpl;

  factory _TourPointModel.fromJson(Map<String, dynamic> json) =
      _$TourPointModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get description;
  @override
  String get panoramaImage;
  @override
  String get narrationAudio;
  @override
  double get yaw;
  @override
  double get pitch;
  @override
  List<String> get connections;
  @override
  List<HotspotModel> get hotspots;

  /// Create a copy of TourPointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourPointModelImplCopyWith<_$TourPointModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HotspotModel _$HotspotModelFromJson(Map<String, dynamic> json) {
  return _HotspotModel.fromJson(json);
}

/// @nodoc
mixin _$HotspotModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get yaw => throw _privateConstructorUsedError;
  double get pitch => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  /// Serializes this HotspotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HotspotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HotspotModelCopyWith<HotspotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotspotModelCopyWith<$Res> {
  factory $HotspotModelCopyWith(
    HotspotModel value,
    $Res Function(HotspotModel) then,
  ) = _$HotspotModelCopyWithImpl<$Res, HotspotModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    double yaw,
    double pitch,
    String icon,
  });
}

/// @nodoc
class _$HotspotModelCopyWithImpl<$Res, $Val extends HotspotModel>
    implements $HotspotModelCopyWith<$Res> {
  _$HotspotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotspotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? yaw = null,
    Object? pitch = null,
    Object? icon = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            yaw: null == yaw
                ? _value.yaw
                : yaw // ignore: cast_nullable_to_non_nullable
                      as double,
            pitch: null == pitch
                ? _value.pitch
                : pitch // ignore: cast_nullable_to_non_nullable
                      as double,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HotspotModelImplCopyWith<$Res>
    implements $HotspotModelCopyWith<$Res> {
  factory _$$HotspotModelImplCopyWith(
    _$HotspotModelImpl value,
    $Res Function(_$HotspotModelImpl) then,
  ) = __$$HotspotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    double yaw,
    double pitch,
    String icon,
  });
}

/// @nodoc
class __$$HotspotModelImplCopyWithImpl<$Res>
    extends _$HotspotModelCopyWithImpl<$Res, _$HotspotModelImpl>
    implements _$$HotspotModelImplCopyWith<$Res> {
  __$$HotspotModelImplCopyWithImpl(
    _$HotspotModelImpl _value,
    $Res Function(_$HotspotModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotspotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? yaw = null,
    Object? pitch = null,
    Object? icon = null,
  }) {
    return _then(
      _$HotspotModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        yaw: null == yaw
            ? _value.yaw
            : yaw // ignore: cast_nullable_to_non_nullable
                  as double,
        pitch: null == pitch
            ? _value.pitch
            : pitch // ignore: cast_nullable_to_non_nullable
                  as double,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HotspotModelImpl implements _HotspotModel {
  const _$HotspotModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.yaw,
    required this.pitch,
    required this.icon,
  });

  factory _$HotspotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotspotModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final double yaw;
  @override
  final double pitch;
  @override
  final String icon;

  @override
  String toString() {
    return 'HotspotModel(id: $id, title: $title, description: $description, yaw: $yaw, pitch: $pitch, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotspotModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, yaw, pitch, icon);

  /// Create a copy of HotspotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotspotModelImplCopyWith<_$HotspotModelImpl> get copyWith =>
      __$$HotspotModelImplCopyWithImpl<_$HotspotModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotspotModelImplToJson(this);
  }
}

abstract class _HotspotModel implements HotspotModel {
  const factory _HotspotModel({
    required final String id,
    required final String title,
    required final String description,
    required final double yaw,
    required final double pitch,
    required final String icon,
  }) = _$HotspotModelImpl;

  factory _HotspotModel.fromJson(Map<String, dynamic> json) =
      _$HotspotModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  double get yaw;
  @override
  double get pitch;
  @override
  String get icon;

  /// Create a copy of HotspotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotspotModelImplCopyWith<_$HotspotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
