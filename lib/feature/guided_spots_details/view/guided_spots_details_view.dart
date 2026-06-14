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
  ConsumerState<GuidedSpotsDetailsView> createState() => _GuidedSpotsDetailsViewState();
}

class _GuidedSpotsDetailsViewState extends ConsumerState<GuidedSpotsDetailsView> {
  final double _sheetExtent = 0.35;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(guidedSpotsDetailsViewModelProvider(widget.tourPoints).notifier).loadAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(guidedSpotsDetailsViewModelProvider(widget.tourPoints));
    final notifier = ref.read(guidedSpotsDetailsViewModelProvider(widget.tourPoints).notifier);
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
            child: PanoramaViewerWidget(imagePath: currentLocationPoint.panoramaImage),
          ),

          // Top gradient + stop indicator
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.overlayLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.border.withValues(alpha: 0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.overlayLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.border.withValues(alpha: 0.3),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          '${strings.stop} ${state.currentIndex + 1} / ${state.tourPoints.length}',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
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
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 36,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.textDisabled,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        currentLocationPoint.title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    if (currentLocationPoint.subtitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                        child: Text(
                          currentLocationPoint.subtitle,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      child: Text(
                        currentLocationPoint.description,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),

                    // Audio player
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.border,
                          width: 0.5,
                        ),
                      ),
                      child: AudioPlayerWidget(
                        player: notifier.audioPlayer,
                        loaded: state.audioLoaded,
                      ),
                    ),

                    // Navigation buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: state.currentIndex > 0
                                  ? () => notifier.goToStop(state.currentIndex - 1)
                                  : null,
                              icon: const Icon(Icons.arrow_back, size: 16),
                              label: Text(strings.previous),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: state.currentIndex < state.tourPoints.length - 1
                                  ? () => notifier.goToStop(state.currentIndex + 1)
                                  : null,
                              icon: const Icon(Icons.arrow_forward, size: 16),
                              label: Text(strings.next),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.gold,
                                foregroundColor: AppColors.background,
                                disabledBackgroundColor: AppColors.goldDark.withValues(alpha: 0.3),
                                disabledForegroundColor: AppColors.textDisabled,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
