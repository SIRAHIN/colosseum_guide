// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guided_spots_details_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$guidedSpotsDetailsViewModelHash() =>
    r'1a44fd7f3560af67cb8dba8e29a98c0299de05c8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$GuidedSpotsDetailsViewModel
    extends BuildlessAutoDisposeNotifier<GuidedSpotsDetailsState> {
  late final List<TourPointModel> tourPoints;

  GuidedSpotsDetailsState build(
    List<TourPointModel> tourPoints,
  );
}

/// See also [GuidedSpotsDetailsViewModel].
@ProviderFor(GuidedSpotsDetailsViewModel)
const guidedSpotsDetailsViewModelProvider = GuidedSpotsDetailsViewModelFamily();

/// See also [GuidedSpotsDetailsViewModel].
class GuidedSpotsDetailsViewModelFamily
    extends Family<GuidedSpotsDetailsState> {
  /// See also [GuidedSpotsDetailsViewModel].
  const GuidedSpotsDetailsViewModelFamily();

  /// See also [GuidedSpotsDetailsViewModel].
  GuidedSpotsDetailsViewModelProvider call(
    List<TourPointModel> tourPoints,
  ) {
    return GuidedSpotsDetailsViewModelProvider(
      tourPoints,
    );
  }

  @override
  GuidedSpotsDetailsViewModelProvider getProviderOverride(
    covariant GuidedSpotsDetailsViewModelProvider provider,
  ) {
    return call(
      provider.tourPoints,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'guidedSpotsDetailsViewModelProvider';
}

/// See also [GuidedSpotsDetailsViewModel].
class GuidedSpotsDetailsViewModelProvider
    extends AutoDisposeNotifierProviderImpl<GuidedSpotsDetailsViewModel,
        GuidedSpotsDetailsState> {
  /// See also [GuidedSpotsDetailsViewModel].
  GuidedSpotsDetailsViewModelProvider(
    List<TourPointModel> tourPoints,
  ) : this._internal(
          () => GuidedSpotsDetailsViewModel()..tourPoints = tourPoints,
          from: guidedSpotsDetailsViewModelProvider,
          name: r'guidedSpotsDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$guidedSpotsDetailsViewModelHash,
          dependencies: GuidedSpotsDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              GuidedSpotsDetailsViewModelFamily._allTransitiveDependencies,
          tourPoints: tourPoints,
        );

  GuidedSpotsDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tourPoints,
  }) : super.internal();

  final List<TourPointModel> tourPoints;

  @override
  GuidedSpotsDetailsState runNotifierBuild(
    covariant GuidedSpotsDetailsViewModel notifier,
  ) {
    return notifier.build(
      tourPoints,
    );
  }

  @override
  Override overrideWith(GuidedSpotsDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: GuidedSpotsDetailsViewModelProvider._internal(
        () => create()..tourPoints = tourPoints,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tourPoints: tourPoints,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<GuidedSpotsDetailsViewModel,
      GuidedSpotsDetailsState> createElement() {
    return _GuidedSpotsDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GuidedSpotsDetailsViewModelProvider &&
        other.tourPoints == tourPoints;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourPoints.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GuidedSpotsDetailsViewModelRef
    on AutoDisposeNotifierProviderRef<GuidedSpotsDetailsState> {
  /// The parameter `tourPoints` of this provider.
  List<TourPointModel> get tourPoints;
}

class _GuidedSpotsDetailsViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<GuidedSpotsDetailsViewModel,
        GuidedSpotsDetailsState> with GuidedSpotsDetailsViewModelRef {
  _GuidedSpotsDetailsViewModelProviderElement(super.provider);

  @override
  List<TourPointModel> get tourPoints =>
      (origin as GuidedSpotsDetailsViewModelProvider).tourPoints;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
