import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/widgets/audio_player_widget.dart';
import 'package:colosseum_guide/feature/guided_spots_details/widgets/panorama_viewer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';


class GuidedSpotsDetailsView extends StatefulWidget {
  final List<TourPointModel> tourPoints;

  const GuidedSpotsDetailsView({super.key, required this.tourPoints});

  @override
  State<GuidedSpotsDetailsView> createState() => _GuidedSpotsDetailsViewState();
}

class _GuidedSpotsDetailsViewState extends State<GuidedSpotsDetailsView> {
  int currentIndex = 0;
  late AudioPlayer _audioPlayer;
  bool _audioLoaded = false;
  bool _loading = true;
  final double _sheetExtent = 0.35;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }



  Future<void> _loadAudio() async {
    if (widget.tourPoints.isEmpty) return;
    setState(() => _audioLoaded = false);
    try {
      await _audioPlayer.setAsset(widget.tourPoints[currentIndex].narrationAudio);
      setState(() => _audioLoaded = true);
    } catch (_) {
      setState(() => _audioLoaded = false);
    }
    setState(() => _loading = false);
  }

  void _goToStop(int index) {
    if (index < 0 || index >= widget.tourPoints.length) return;
    _audioPlayer.stop();
    setState(() => currentIndex = index);
    _loadAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFFC107)),
        ),
      );
    }

    final currentLocationPoint = widget.tourPoints[currentIndex];

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
                          'Stop ${currentIndex + 1} / ${widget.tourPoints.length}',
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
                        player: _audioPlayer,
                        loaded: _audioLoaded,
                      ),
                    ),

                    // Navigation buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: currentIndex > 0
                                  ? () => _goToStop(currentIndex - 1)
                                  : null,
                              icon: const Icon(Icons.arrow_back, size: 16),
                              label: const Text('Previous'),
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
                              onPressed: currentIndex < widget.tourPoints.length - 1
                                  ? () => _goToStop(currentIndex + 1)
                                  : null,
                              icon: const Icon(Icons.arrow_forward, size: 16),
                              label: const Text('Next'),
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
