import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/language_select/data/local_language_data/local_language_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2500), () async {
      if (mounted) {
        final language = await ref.read(localLanguageDataProvider).getLanguage();
        if (language.isLanguageSelected) {
          context.goNamed(guidedLandingViewName);
        } else {
          context.goNamed(languageSelectViewName, extra: guidedLandingViewName);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.surfaceHigh,
                            AppColors.surface,
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gold.withValues(alpha: 0.08),
                            blurRadius: 40,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [AppColors.goldLight, AppColors.gold, AppColors.bronze],
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.stadium,
                          size: 72,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    strings.colosseumGuide,
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 48,
                    height: 1,
                    color: AppColors.gold.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    strings.yourJourneyThroughHistory,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 56),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: AppColors.gold.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
