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
    context.goNamed(widget.reRouteName ?? guidedLandingViewName);
  }

  void _onSkip() {
    context.goNamed(widget.reRouteName ?? guidedLandingViewName);
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    final staticlanguagesdata = ref.watch(staticLanguagesProvider);
    final languageSelectState = ref.watch(languageSelectViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [AppColors.surfaceHigh, AppColors.surface],
                      ),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.goldLight, AppColors.gold],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.translate,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    strings.selectLanguage,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    strings.chooseLanguage,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _onSkip,
                  child: Text(
                    strings.skip,
                    style: TextStyle(
                      color: AppColors.textDisabled,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),

            // Language list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                itemCount: staticlanguagesdata.length,
                itemBuilder: (context, index) {
                  final lang = staticlanguagesdata[index];
                  return LanguageListTile(
                    title: lang.name,
                    subtitle: lang.nativeName,
                    icon: lang.icon,
                    isSelected: languageSelectState.selectedIndex == index,
                    onTap: () => ref
                        .read(languageSelectViewModelProvider.notifier)
                        .selectLanguage(index: index, language: lang.name, isLanguageSelected: true),
                  );
                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 12, 28, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onNext,
                  child: Text(
                    strings.next,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
