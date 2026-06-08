import 'package:colosseum_guide/core/localization/app_localizations.dart';
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
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFFC107)),
        ),
      );
    }

    final currentLocationPoint = state.tourPoints[state.currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
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
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
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
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${strings.stop} ${state.currentIndex + 1} / ${state.tourPoints.length}',
                          style: const TextStyle(
                            color: Color(0xFFFFC107),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        currentLocationPoint.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (currentLocationPoint.subtitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                        child: Text(
                          currentLocationPoint.subtitle,
                          style: const TextStyle(
                            color: Color(0xFFFFC107),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      child: Text(
                        currentLocationPoint.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),

                    // Audio player
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(16),
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
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white70,
                                side: const BorderSide(color: Colors.white24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
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
                                backgroundColor: const Color(0xFFFFC107),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
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