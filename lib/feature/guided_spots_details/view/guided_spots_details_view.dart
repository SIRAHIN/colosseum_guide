import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/view_model/guided_spots_details_view_model.dart';
import 'package:colosseum_guide/feature/guided_spots_details/widgets/audio_player_widget.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Static image background (top portion) ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.50,
            child: Stack(
              children: [
                // Image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(currentLocationPoint.panoramaImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay — fade into background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.35, 0.75, 1.0],
                      colors: [
                        AppColors.background.withValues(alpha: 0.5),
                        Colors.transparent,
                        AppColors.background.withValues(alpha: 0.5),
                        AppColors.background,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Top bar ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button — glassmorphism
                    _GlassButton(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textPrimary,
                        size: 18,
                      ),
                    ),
                    // Stop indicator pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.overlayLight,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${strings.stop} ${state.currentIndex + 1}/${state.tourPoints.length}',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
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

          // ── Bottom content sheet ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: screenHeight * 0.42,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 0.5),
                ),
              ),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Drag handle + decorative accent
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.textDisabled,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Title section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gold accent with decorative dots
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: AppColors.gold,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 2,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Title
                          Text(
                            currentLocationPoint.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                              height: 1.15,
                            ),
                          ),
                          if (currentLocationPoint.subtitle.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              currentLocationPoint.subtitle,
                              style: TextStyle(
                                color: AppColors.gold.withValues(alpha: 0.85),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Description
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 18, 28, 8),
                      child: Text(
                        currentLocationPoint.description,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.75,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),

                  // ── Audio player — premium container ──
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.surfaceHigh,
                            AppColors.background,
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gold.withValues(alpha: 0.05),
                            blurRadius: 24,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header row with decorative line
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.goldGradient,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.gold.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.headphones_rounded,
                                    color: AppColors.background,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Audio Guide',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.gold.withValues(alpha: 0.3),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Audio player widget
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
                            child: AudioPlayerWidget(
                              player: notifier.audioPlayer,
                              loaded: state.audioLoaded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Navigation buttons ──
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
                      child: Row(
                        children: [
                          Expanded(
                            child: _NavButton(
                              label: strings.previous,
                              icon: Icons.arrow_back_rounded,
                              enabled: state.currentIndex > 0,
                              onTap: () =>
                                  notifier.goToStop(state.currentIndex - 1),
                              primary: false,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _NavButton(
                              label: strings.next,
                              icon: Icons.arrow_forward_rounded,
                              enabled:
                                  state.currentIndex < state.tourPoints.length - 1,
                              onTap: () =>
                                  notifier.goToStop(state.currentIndex + 1),
                              primary: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────

class _GlassButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _GlassButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.overlayLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.6),
            width: 0.5,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  final bool primary;

  const _NavButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    if (primary) {
      return GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: enabled ? AppColors.goldGradient : null,
            color: enabled ? null : AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(16),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: enabled ? AppColors.background : AppColors.textDisabled,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                icon,
                size: 16,
                color: enabled ? AppColors.background : AppColors.textDisabled,
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.surfaceHigh
              : AppColors.surfaceHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: enabled ? AppColors.textSecondary : AppColors.textDisabled,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: enabled ? AppColors.textSecondary : AppColors.textDisabled,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
