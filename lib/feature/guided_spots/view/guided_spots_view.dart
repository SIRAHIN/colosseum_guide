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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed(
                    languageSelectViewName,
                    extra: guidedSpotsViewName,
                  );
                },
                icon: const Icon(Icons.language, size: 22),
              ),
            ],
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                strings.explore,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surfaceHigh,
                      AppColors.surface,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return guidedSpotsState.tours.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: CircularProgressIndicator(
                            color: AppColors.gold.withValues(alpha: 0.6),
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : _TourCard(
                        tour: guidedSpotsState.tours[index],
                        strings: strings,
                        onTap: () =>
                            guidedSpotsState.tours[index].points.isEmpty
                            ? toastification.show(
                                title: Text(
                                  strings.tourUnavailable,
                                ),
                                type: ToastificationType.warning,
                                style: ToastificationStyle.flat,
                                autoCloseDuration: Duration(seconds: 3),
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

class _TourCard extends StatelessWidget {
  final TourModel tour;
  final AppStrings strings;
  final VoidCallback onTap;

  const _TourCard({required this.tour, required this.strings, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image with overlays
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
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
                  // Warm bottom gradient
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, AppColors.surface.withValues(alpha: 0.9)],
                        ),
                      ),
                    ),
                  ),
                  // Duration badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.overlay,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: AppColors.gold,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${tour.durationMinutes} ${strings.min}',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Stops count badge
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.overlay,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.gold,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${tour.points.length} ${strings.stops}',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Text content
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.title,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      tour.subtitle,
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tour.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Spacer(),
                        _StartButton(strings: strings, onTap: onTap),
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

class _StartButton extends StatelessWidget {
  final AppStrings strings;
  final VoidCallback onTap;

  const _StartButton({required this.strings, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.play_arrow, size: 16),
      label: Text(strings.startTour),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.background,
        disabledBackgroundColor: AppColors.goldDark.withValues(alpha: 0.3),
        disabledForegroundColor: AppColors.textDisabled,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
