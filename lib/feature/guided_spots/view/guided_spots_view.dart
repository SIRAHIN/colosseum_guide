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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.background,
        shape: const StadiumBorder(),
        label: const Text(
          'Ask Aurelia',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
        icon: const Icon(Icons.auto_awesome, size: 18),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                strings.explore,
                style: TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed(settingsViewName);
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Icon(Icons.settings, size: 18, color: AppColors.gold),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 90),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return guidedSpotsState.tours.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: CircularProgressIndicator(
                            color: AppColors.gold.withValues(alpha: 0.6),
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : _ImmersiveTourCard(
                        tour: guidedSpotsState.tours[index],
                        strings: strings,
                        onTap: () =>
                            guidedSpotsState.tours[index].points.isEmpty
                            ? toastification.show(
                                title: Text(strings.tourUnavailable),
                                type: ToastificationType.warning,
                                style: ToastificationStyle.flat,
                                autoCloseDuration: const Duration(seconds: 3),
                              )
                            : _navigateToGuide(
                                context,
                                guidedSpotsState.tours[index],
                              ),
                      );
              }, childCount: guidedSpotsState.tours.length),
            ),
          ),
        ],
      ),
    );
  }
}

void _navigateToGuide(BuildContext context, TourModel tour) {
  context.pushNamed(guidedSpotsDetailsName, extra: tour.points);
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full-width immersive image
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.asset(
                      tour.coverImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.surfaceHigh,
                        child: Icon(
                          Icons.photo_camera_outlined,
                          color: AppColors.textDisabled,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  // Bottom gradient on image
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.surface.withValues(alpha: 0.95),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Top badges row
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Badge(
                          icon: Icons.location_on,
                          text: '${tour.points.length} ${strings.stops}',
                          color: AppColors.overlay,
                        ),
                        _Badge(
                          icon: Icons.schedule,
                          text: '${tour.durationMinutes} ${strings.min}',
                          color: AppColors.overlay,
                        ),
                      ],
                    ),
                  ),
                  // Title overlay on image bottom
                  Positioned(
                    left: 16,
                    bottom: 12,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tour.title,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tour.subtitle,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Description + CTA
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        if (!hasPoints)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceHigh,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.border,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              'Coming Soon',
                              style: TextStyle(
                                color: AppColors.textDisabled,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        else
                          Icon(
                            Icons.panorama,
                            size: 14,
                            color: AppColors.textDisabled,
                          ),
                        const Spacer(),
                        _StartButton(
                          strings: strings,
                          onTap: onTap,
                          enabled: hasPoints,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _Badge({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.gold, size: 12),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final AppStrings strings;
  final VoidCallback onTap;
  final bool enabled;

  const _StartButton({
    required this.strings,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: enabled ? onTap : null,
      icon: const Icon(Icons.play_arrow, size: 16),
      label: Text(strings.startTour),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.background,
        disabledBackgroundColor: AppColors.goldDark.withValues(alpha: 0.3),
        disabledForegroundColor: AppColors.textDisabled,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
