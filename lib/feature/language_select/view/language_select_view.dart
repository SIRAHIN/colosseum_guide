import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
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
  void _onNext() {
     widget.reRouteName == settingsViewName ? context.pop() : context.goNamed(widget.reRouteName ?? guidedLandingViewName);
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    final staticlanguagesdata = ref.watch(staticLanguagesProvider);
    final languageSelectState = ref.watch(languageSelectViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.background,
      body: SafeArea(
        
        child: Column(
          children: [
            // Custom header
              Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
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
                        color: AppColors.gold.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.goldGradient.createShader(bounds),
                      child: const Icon(
                        Icons.translate,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    strings.selectLanguage,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gold,
                      letterSpacing: 1,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    strings.chooseLanguage,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Divider
                  Container(
                    width: 40,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.gold.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Language list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                itemCount: staticlanguagesdata.length,
                itemBuilder: (context, index) {
                  final lang = staticlanguagesdata[index];
                  return LanguageListTile(
                    title: lang.name,
                    subtitle: lang.nativeName,
                    icon: lang.icon,
                    isSelected:
                        languageSelectState.selectedIndex == index,
                    onTap: () => ref
                        .read(languageSelectViewModelProvider.notifier)
                        .selectLanguage(
                          index: index,
                          language: lang.name,
                          isLanguageSelected: true,
                        ),
                  );
                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.background,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    strings.next,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
