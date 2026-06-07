import 'package:colosseum_guide/core/route/route_manager.dart';
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
    final staticlanguagesdata = ref.watch(staticLanguagesProvider);
    final languageSelectState = ref.watch(languageSelectViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
      ),
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
              child: Column(
                children: [
                  const Icon(
                    Icons.translate,
                    size: 48,
                    color: Color(0xFFFFC107),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Language',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your preferred language',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Skip button (top)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _onSkip,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Language list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8),
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

            // Next button (bottom)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    disabledBackgroundColor: Colors.white.withValues(
                      alpha: 0.1,
                    ),
                    foregroundColor: const Color(0xFF1A1A2E),
                    disabledForegroundColor: Colors.white38,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
