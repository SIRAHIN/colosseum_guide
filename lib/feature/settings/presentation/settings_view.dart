import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/language_select/data/local_language_data/local_language_data.dart';
import 'package:colosseum_guide/feature/settings/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const String _appVersion = '1.0.0';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final strings = ref.watch(appStringsProvider);
    final language = ref.watch(localLanguageDataProvider).getLanguage();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          strings.settings,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            // ── Profile ──
            const _ProfileHeader(name: 'Marcus Aurelius'),
            const SizedBox(height: 24),

            // ── Preferences ──
            _SectionLabel(title: strings.preferences),
            SettingsListTile(
              icon: Icons.translate,
              title: strings.language,
              subtitle: language.selectedLanguage,
              onTap: () => context.pushNamed(
                languageSelectViewName,
                extra: settingsViewName,
              ),
            ),
            const SizedBox(height: 24),

            // ── Support ──
            _SectionLabel(title: strings.support),
            SettingsListTile(
              icon: Icons.support_agent,
              title: strings.contactSupport,
              subtitle: strings.getHelpFromOurTeam,
              onTap: () {},
            ),
            SettingsListTile(
              icon: Icons.help_outline,
              title: strings.faqs,
              subtitle: strings.frequentlyAskedQuestions,
              onTap: () {},
            ),
            const SizedBox(height: 24),

            // ── About ──
            _SectionLabel(title: strings.about),
            SettingsListTile(
              icon: Icons.privacy_tip_outlined,
              title: strings.privacyPolicy,
              onTap: () {},
            ),
            SettingsListTile(
              icon: Icons.info_outline,
              title: strings.appVersion,
              trailing: Text(
                _appVersion,
                style: const TextStyle(
                  color: AppColors.textDisabled,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  const _ProfileHeader({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.goldGradient,
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.background,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'View and edit your profile',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.textDisabled,
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.gold,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
