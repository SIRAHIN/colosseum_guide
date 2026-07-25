import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LanguageListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? flag;
  final IconData icon;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback onTap;
  final Color? selectedColor;

  const LanguageListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.flag,
    this.icon = Icons.language_rounded,
    required this.isSelected,
    this.isAvailable = true,
    required this.onTap,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final accent = selectedColor ?? AppColors.gold;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: isSelected
            ? accent.withValues(alpha: 0.08)
            : (isAvailable
                ? AppColors.surface
                : AppColors.surface.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? accent.withValues(alpha: 0.7)
                    : (isAvailable
                        ? AppColors.border
                        : AppColors.border.withValues(alpha: 0.3)),
                width: isSelected ? 1.5 : 0.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.1),
                        blurRadius: 12,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Flag / Icon Container
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? accent.withValues(alpha: 0.15)
                        : (isAvailable
                            ? AppColors.surfaceHigh
                            : AppColors.surfaceHigh.withValues(alpha: 0.4)),
                    border: Border.all(
                      color: isSelected
                          ? accent.withValues(alpha: 0.4)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: flag != null && flag!.isNotEmpty
                      ? Text(
                          flag!,
                          style: const TextStyle(fontSize: 20),
                        )
                      : Icon(
                          icon,
                          color: isSelected
                              ? accent
                              : (isAvailable
                                  ? AppColors.textSecondary
                                  : AppColors.textDisabled),
                          size: 20,
                        ),
                ),
                const SizedBox(width: 14),
                // Language Name & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : (isAvailable
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary
                                          .withValues(alpha: 0.7)),
                              fontSize: 16,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: isSelected
                                ? accent.withValues(alpha: 0.9)
                                : (isAvailable
                                    ? AppColors.textSecondary
                                    : AppColors.textDisabled),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status Badge / Trailing indicator
                if (isAvailable) ...[
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: accent.withValues(alpha: 0.4), width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded,
                              color: accent, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Icon(
                      Icons.radio_button_unchecked,
                      color: AppColors.textDisabled,
                      size: 20,
                    ),
                ] else ...[
                  // Coming Soon Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.bronze.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.bronze.withValues(alpha: 0.3),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          color: AppColors.gold.withValues(alpha: 0.7),
                          size: 11,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Coming Soon',
                          style: TextStyle(
                            color: AppColors.gold.withValues(alpha: 0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

