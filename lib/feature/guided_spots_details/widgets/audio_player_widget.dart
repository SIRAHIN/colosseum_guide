import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final bool loaded;

  const AudioPlayerWidget({
    super.key,
    required this.player,
    required this.loaded,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  void initState() {
    super.initState();
    widget.player.positionStream.listen((_) {
      if (mounted) setState(() {});
    });
    widget.player.durationStream.listen((_) {
      if (mounted) setState(() {});
    });
    widget.player.playerStateStream.listen((_) {
      if (mounted) setState(() {});
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loaded) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No audio loaded',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white38, fontSize: 14),
        ),
      );
    }

    final duration = widget.player.duration ?? Duration.zero;
    final position = widget.player.position;
    final isPlaying = widget.player.playing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              _formatDuration(position),
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            Expanded(
              child: Slider(
                value: duration.inMilliseconds > 0
                    ? position.inMilliseconds / duration.inMilliseconds
                    : 0,
                onChanged: (value) {
                  widget.player.seek(Duration(
                    milliseconds: (value * duration.inMilliseconds).round(),
                  ));
                },
                activeColor: const Color(0xFFFFC107),
                inactiveColor: Colors.white24,
              ),
            ),
            Text(
              _formatDuration(duration),
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            size: 48,
            color: const Color(0xFFFFC107),
          ),
          onPressed: () {
            if (isPlaying) {
              widget.player.pause();
            } else {
              widget.player.play();
            }
          },
        ),
      ],
    );
  }
}
