import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots/view_model/guided_spots_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class GuidedSpotsView extends ConsumerWidget {
  const GuidedSpotsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guidedSpotsState = ref.watch(guidedSpotsViewModelProvider);
    final strings = ref.watch(appStringsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.background,
          elevation: 0,
          shape: const StadiumBorder(),
          label: const Text(
            'Ask Aurelia',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          icon: const Icon(Icons.auto_awesome_rounded, size: 18),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header Bar ─────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(0, -0.6),
                          radius: 1.2,
                          colors: [
                            AppColors.gold.withValues(alpha: 0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.gold.withValues(alpha: 0.3),
                              width: 0.8,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.stadium_rounded,
                                  color: AppColors.gold, size: 12),
                              SizedBox(width: 6),
                              Text(
                                'AURELIA AUDIO GUIDES',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.goldGradient.createShader(bounds),
                          child: Text(
                            strings.explore,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Discover the mysteries of ancient Rome with expert audio narration',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () => context.pushNamed(settingsViewName),
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.8),
                        width: 0.8,
                      ),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      size: 20,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Tour Cards List ─────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (guidedSpotsState.tours.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: CircularProgressIndicator(
                          color: AppColors.gold.withValues(alpha: 0.6),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  final tour = guidedSpotsState.tours[index];
                  return _ImmersiveTourCard(
                    tour: tour,
                    strings: strings,
                    onTap: () => tour.points.isEmpty
                        ? toastification.show(
                            title: Text(strings.tourUnavailable),
                            type: ToastificationType.warning,
                            style: ToastificationStyle.flat,
                            autoCloseDuration: const Duration(seconds: 3),
                          )
                        : _navigateToTourPoints(context, tour),
                  );
                },
                childCount: guidedSpotsState.tours.isEmpty
                    ? 1
                    : guidedSpotsState.tours.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _navigateToTourPoints(BuildContext context, TourModel tour) {
  context.pushNamed(
    tourPointsViewName,
    extra: tour.points,
  );
}

class _ImmersiveTourCard extends StatelessWidget {
  final TourModel tour;
  final AppStrings strings;
  final VoidCallback onTap;

  const _ImmersiveTourCard({
    required this.tour,
    required this.strings,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasPoints = tour.points.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.gold.withValues(alpha: 0.1),
          highlightColor: AppColors.gold.withValues(alpha: 0.05),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.8),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Cover Image Stack ──────────────────────────────────────
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.asset(
                        tour.coverImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: AppColors.surfaceHigh,
                          child: const Icon(
                            Icons.photo_camera_outlined,
                            color: AppColors.textDisabled,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay on image bottom
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.45, 1.0],
                            colors: [
                              Colors.black.withValues(alpha: 0.3),
                              Colors.transparent,
                              AppColors.surface,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Glassmorphic top badges
                    Positioned(
                      top: 14,
                      left: 14,
                      right: 14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _GlassBadge(
                            icon: Icons.place_rounded,
                            text: '${tour.points.length} ${strings.stops}',
                          ),
                          _GlassBadge(
                            icon: Icons.schedule_rounded,
                            text: '${tour.durationMinutes} ${strings.min}',
                          ),
                        ],
                      ),
                    ),
                    // Title & Subtitle Overlay on Image Bottom
                    Positioned(
                      left: 18,
                      bottom: 12,
                      right: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tour.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tour.subtitle,
                            style: const TextStyle(
                              color: AppColors.goldLight,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // ── Body & Action Section ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tour.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Feature Tags Row
                      Row(
                        children: [
                          const _FeatureChip(
                            icon: Icons.headphones_rounded,
                            label: 'Full Audio',
                          ),
                          const SizedBox(width: 8),
                          const _FeatureChip(
                            icon: Icons.offline_pin_rounded,
                            label: 'Offline Ready',
                          ),
                          const SizedBox(width: 8),
                          const _FeatureChip(
                            icon: Icons.subtitles_rounded,
                            label: 'Transcripts',
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Start Tour Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: hasPoints ? onTap : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            disabledBackgroundColor: AppColors.surfaceHigh,
                            foregroundColor: AppColors.background,
                            disabledForegroundColor: AppColors.textDisabled,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                hasPoints
                                    ? Icons.play_arrow_rounded
                                    : Icons.lock_outline_rounded,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                hasPoints ? strings.startTour : 'Coming Soon',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _GlassBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.35),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.gold, size: 13),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.gold),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

