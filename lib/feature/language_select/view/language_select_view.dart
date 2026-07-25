import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/services/onboarding_cache.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/language_select/components/language_list_tile.dart';
import 'package:colosseum_guide/feature/language_select/data/static_languages_data/static_languages_data.dart';
import 'package:colosseum_guide/feature/language_select/view_model/language_select_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectView extends ConsumerStatefulWidget {
  final String? reRouteName;
  const LanguageSelectView({super.key, this.reRouteName});

  @override
  ConsumerState<LanguageSelectView> createState() => _LanguageSelectViewState();
}

class _LanguageSelectViewState extends ConsumerState<LanguageSelectView> {
  Future<void> _onNext() async {
    final languageState = ref.read(languageSelectViewModelProvider);
    final selectedLang = languageState.selectedLanguage.isEmpty
        ? 'English'
        : languageState.selectedLanguage;

    // Save language selection state
    ref.read(languageSelectViewModelProvider.notifier).selectLanguage(
          index: languageState.selectedIndex,
          language: selectedLang,
          isLanguageSelected: true,
        );

    // Mark onboarding language selected
    await ref.read(onboardingCacheProvider).setLanguageSelected();

    if (!mounted) return;

    if (widget.reRouteName == settingsViewName) {
      context.pop();
    } else {
      context.goNamed(widget.reRouteName ?? guidedLandingViewName);
    }
  }

  void _showComingSoonSnackBar(BuildContext context, Language lang) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(lang.flag, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${lang.name} audio guide is coming soon! English is currently available.',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.surfaceHigh,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.gold.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    final staticLanguages = ref.watch(staticLanguagesProvider);
    final languageSelectState = ref.watch(languageSelectViewModelProvider);
    final theme = Theme.of(context);

    final availableLanguages =
        staticLanguages.where((l) => l.isAvailable).toList();
    final comingSoonLanguages =
        staticLanguages.where((l) => !l.isAvailable).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: (widget.reRouteName == settingsViewName || context.canPop())
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.gold, size: 20),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom header
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 12),
              child: Column(
                children: [
                  // Emblem
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [AppColors.surfaceHigh, AppColors.surface],
                      ),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.goldGradient.createShader(bounds),
                      child: const Icon(
                        Icons.translate_rounded,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    strings.selectLanguage,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gold,
                      letterSpacing: 1.2,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'English audio guide is available now.\nAdditional languages will be released soon.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Divider
                  Container(
                    width: 48,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.gold.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Language list divided into sections
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: [
                  // Available Section Label
                  Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 8, top: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'AVAILABLE NOW',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Available Languages
                  ...availableLanguages.map((lang) {
                    final index = staticLanguages.indexOf(lang);
                    final isSelected =
                        languageSelectState.selectedIndex == index ||
                            languageSelectState.selectedLanguage == lang.name;
                    return LanguageListTile(
                      title: lang.name,
                      subtitle: '${lang.nativeName} • Full Audio Guide',
                      flag: lang.flag,
                      icon: lang.icon,
                      isSelected: isSelected,
                      isAvailable: true,
                      onTap: () => ref
                          .read(languageSelectViewModelProvider.notifier)
                          .selectLanguage(
                            index: index,
                            language: lang.name,
                            isLanguageSelected: true,
                          ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // Releasing Soon Section Label
                  Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: AppColors.textDisabled,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'RELEASING SOON',
                          style: TextStyle(
                            color: AppColors.textDisabled,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Coming Soon Languages
                  ...comingSoonLanguages.map((lang) {
                    return LanguageListTile(
                      title: lang.name,
                      subtitle: '${lang.nativeName} • Releasing Soon',
                      flag: lang.flag,
                      icon: lang.icon,
                      isSelected: false,
                      isAvailable: false,
                      onTap: () => _showComingSoonSnackBar(context, lang),
                    );
                  }),
                ],
              ),
            ),

            // Next / Confirm button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.background,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        widget.reRouteName == settingsViewName
                            ? 'Save Preference'
                            : 'Continue with English',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You can change your language anytime in Settings',
                    style: TextStyle(
                      color: AppColors.textDisabled,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

