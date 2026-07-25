import 'dart:async';

import 'package:colosseum_guide/core/theme/app_colors.dart';
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

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  double _volume = 1.0;
  double _playbackSpeed = 1.0;
  bool _showVolume = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final List<StreamSubscription> _subs = [];

  static const _speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  @override
  void initState() {
    super.initState();
    _volume = widget.player.volume;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _subs.add(widget.player.positionStream.listen((_) {
      if (mounted) setState(() {});
    }));
    _subs.add(widget.player.durationStream.listen((_) {
      if (mounted) setState(() {});
    }));
    _subs.add(widget.player.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() {});
      if (state.playing) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }));
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    _pulseController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (h > 0) return '$h:$m:$s';
    return '$m:$s';
  }

  void _seekRelative(int seconds) {
    final duration = widget.player.duration ?? Duration.zero;
    final newPos = widget.player.position + Duration(seconds: seconds);
    final clamped = newPos < Duration.zero
        ? Duration.zero
        : newPos > duration
            ? duration
            : newPos;
    widget.player.seek(clamped);
  }

  void _cycleSpeed() {
    final idx = _speeds.indexOf(_playbackSpeed);
    final next = _speeds[(idx + 1) % _speeds.length];
    setState(() => _playbackSpeed = next);
    widget.player.setSpeed(next);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loaded) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_off_rounded,
                color: AppColors.textDisabled, size: 16),
            const SizedBox(width: 8),
            Text(
              'No audio available',
              style: TextStyle(color: AppColors.textDisabled, fontSize: 13),
            ),
          ],
        ),
      );
    }

    final duration = widget.player.duration ?? Duration.zero;
    final position = widget.player.position;
    final isPlaying = widget.player.playing;
    final progress = duration.inMilliseconds > 0
        ? (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Progress bar ──────────────────────────────────────────────
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape:
                const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape:
                const RoundSliderOverlayShape(overlayRadius: 14),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: progress,
            onChanged: (v) {
              widget.player.seek(
                Duration(
                    milliseconds: (v * duration.inMilliseconds).round()),
              );
            },
            activeColor: AppColors.gold,
            inactiveColor: AppColors.border,
            thumbColor: AppColors.goldLight,
          ),
        ),

        // ── Time labels ───────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                _formatDuration(duration),
                style: TextStyle(
                  color: AppColors.textDisabled,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Controls row ──────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Speed button
            _SpeedButton(
              speed: _playbackSpeed,
              onTap: _cycleSpeed,
            ),

            // Rewind 10s
            _SeekButton(
              icon: Icons.replay_10_rounded,
              onTap: () => _seekRelative(-10),
            ),

            // Play / Pause — center hero
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) => Transform.scale(
                scale: isPlaying ? _pulseAnimation.value : 1.0,
                child: child,
              ),
              child: GestureDetector(
                onTap: () {
                  if (isPlaying) {
                    widget.player.pause();
                  } else {
                    widget.player.play();
                  }
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: AppColors.goldGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: AppColors.background,
                    size: 32,
                  ),
                ),
              ),
            ),

            // Forward 10s
            _SeekButton(
              icon: Icons.forward_10_rounded,
              onTap: () => _seekRelative(10),
            ),

            // Volume toggle
            _VolumeToggle(
              showVolume: _showVolume,
              volume: _volume,
              onToggle: () => setState(() => _showVolume = !_showVolume),
            ),
          ],
        ),

        // ── Volume slider (collapsible) ───────────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: _showVolume
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                  child: Row(
                    children: [
                      Icon(
                        _volume == 0
                            ? Icons.volume_off_rounded
                            : _volume < 0.5
                                ? Icons.volume_down_rounded
                                : Icons.volume_up_rounded,
                        color: AppColors.gold,
                        size: 18,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12),
                          ),
                          child: Slider(
                            value: _volume,
                            onChanged: (v) {
                              setState(() => _volume = v);
                              widget.player.setVolume(v);
                            },
                            activeColor: AppColors.goldLight,
                            inactiveColor: AppColors.border,
                            thumbColor: AppColors.goldLight,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${(_volume * 100).round()}%',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: AppColors.textDisabled,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

class _SeekButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SeekButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 22),
      ),
    );
  }
}

class _SpeedButton extends StatelessWidget {
  final double speed;
  final VoidCallback onTap;

  const _SpeedButton({required this.speed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = speed != 1.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.gold.withValues(alpha: 0.15)
              : AppColors.surfaceHigh,
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive ? AppColors.gold.withValues(alpha: 0.5) : AppColors.border,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            '${speed == speed.truncate() ? speed.toInt() : speed}x',
            style: TextStyle(
              color: isActive ? AppColors.gold : AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _VolumeToggle extends StatelessWidget {
  final bool showVolume;
  final double volume;
  final VoidCallback onToggle;

  const _VolumeToggle(
      {required this.showVolume,
      required this.volume,
      required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final icon = volume == 0
        ? Icons.volume_off_rounded
        : volume < 0.5
            ? Icons.volume_down_rounded
            : Icons.volume_up_rounded;

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: showVolume
              ? AppColors.gold.withValues(alpha: 0.15)
              : AppColors.surfaceHigh,
          shape: BoxShape.circle,
          border: Border.all(
            color: showVolume
                ? AppColors.gold.withValues(alpha: 0.5)
                : AppColors.border,
            width: 0.5,
          ),
        ),
        child: Icon(
          icon,
          color: showVolume ? AppColors.gold : AppColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}
