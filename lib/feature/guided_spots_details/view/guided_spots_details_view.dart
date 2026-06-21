import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/view_model/guided_spots_details_view_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/widgets/audio_player_widget.dart';
import 'package:colosseum_guide/feature/guided_spots_details/widgets/panorama_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuidedSpotsDetailsView extends ConsumerStatefulWidget {
  final List<TourPointModel> tourPoints;

  const GuidedSpotsDetailsView({super.key, required this.tourPoints});

  @override
  ConsumerState<GuidedSpotsDetailsView> createState() =>
      _GuidedSpotsDetailsViewState();
}

class _GuidedSpotsDetailsViewState extends ConsumerState<GuidedSpotsDetailsView> {
  final double _sheetExtent = 0.38;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(guidedSpotsDetailsViewModelProvider(widget.tourPoints).notifier)
          .loadAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(guidedSpotsDetailsViewModelProvider(widget.tourPoints));
    final notifier =
        ref.read(guidedSpotsDetailsViewModelProvider(widget.tourPoints).notifier);
    final strings = ref.watch(appStringsProvider);

    if (state.loading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.gold.withValues(alpha: 0.6),
            strokeWidth: 2,
          ),
        ),
      );
    }

    final currentLocationPoint = state.tourPoints[state.currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Full-screen 360° panorama
          Positioned.fill(
            child: PanoramaViewerWidget(
                imagePath: currentLocationPoint.panoramaImage),
          ),

          // Top gradient + controls
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.overlayLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.border.withValues(alpha: 0.4),
                              width: 0.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.overlayLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.border.withValues(alpha: 0.4),
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.gold,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${strings.stop} ${state.currentIndex + 1}/${state.tourPoints.length}',
                              style: TextStyle(
                                color: AppColors.gold,
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
                ),
              ),
            ),
          ),

          // Draggable bottom sheet
          DraggableScrollableSheet(
            initialChildSize: _sheetExtent,
            minChildSize: 0.15,
            maxChildSize: 0.75,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  border: Border.all(
                    color: AppColors.border,
                    width: 0.5,
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.textDisabled,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Stop indicator + title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subtle gold accent line
                          Container(
                            width: 32,
                            height: 2,
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            currentLocationPoint.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                              height: 1.2,
                            ),
                          ),
                          if (currentLocationPoint.subtitle.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              currentLocationPoint.subtitle,
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                      child: Text(
                        currentLocationPoint.description,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.7,
                        ),
                      ),
                    ),

                    // Audio player — cleaner design
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.border,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.headphones,
                                color: AppColors.gold.withValues(alpha: 0.7),
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Audio Guide',
                                style: TextStyle(
                                  color: AppColors.textDisabled,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          AudioPlayerWidget(
                            player: notifier.audioPlayer,
                            loaded: state.audioLoaded,
                          ),
                        ],
                      ),
                    ),

                    // Navigation buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: state.currentIndex > 0
                                  ? () =>
                                      notifier.goToStop(state.currentIndex - 1)
                                  : null,
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: state.currentIndex > 0
                                      ? AppColors.surfaceHigh
                                      : AppColors.surfaceHigh.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: AppColors.border,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      size: 16,
                                      color: state.currentIndex > 0
                                          ? AppColors.textSecondary
                                          : AppColors.textDisabled,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      strings.previous,
                                      style: TextStyle(
                                        color: state.currentIndex > 0
                                            ? AppColors.textSecondary
                                            : AppColors.textDisabled,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: state.currentIndex < state.tourPoints.length - 1
                                  ? () =>
                                      notifier.goToStop(state.currentIndex + 1)
                                  : null,
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: state.currentIndex < state.tourPoints.length - 1
                                      ? AppColors.gold
                                      : AppColors.goldDark.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      strings.next,
                                      style: TextStyle(
                                        color: state.currentIndex < state.tourPoints.length - 1
                                            ? AppColors.background
                                            : AppColors.textDisabled,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 16,
                                      color: state.currentIndex < state.tourPoints.length - 1
                                          ? AppColors.background
                                          : AppColors.textDisabled,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
