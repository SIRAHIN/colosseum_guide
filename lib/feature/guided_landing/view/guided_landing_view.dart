import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GuidedLandingView extends ConsumerWidget {
  const GuidedLandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(appStringsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Decorative emblem
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.surfaceHigh, AppColors.surface],
                    ),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.06),
                        blurRadius: 48,
                        spreadRadius: 12,
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.goldLight, AppColors.gold, AppColors.bronze],
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.stadium,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                strings.colosseumGuide,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: AppColors.gold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 40,
                  height: 1,
                  color: AppColors.gold.withValues(alpha: 0.3),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                strings.landingDescription,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(guidedSpotsViewName);
                },
                child: Text(strings.startTour),
              ),
              const SizedBox(height: 12),
              // Subtle decorative line
              Center(
                child: Container(
                  width: 120,
                  height: 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.gold.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
