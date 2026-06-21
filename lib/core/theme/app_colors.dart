import 'package:flutter/material.dart';

/// Ancient Roman inspired color palette — deep darks, warm gold, aged bronze.
class AppColors {
  AppColors._();

  // ── Backgrounds ──
  static const Color background = Color(0xFF0A0908);
  static const Color surface = Color(0xFF15120F);
  static const Color surfaceHigh = Color(0xFF1F1A15);
  static const Color surfaceHighest = Color(0xFF2A231C);

  // ── Primary — Gold / Bronze ──
  static const Color gold = Color(0xFFC9A24B);
  static const Color goldLight = Color(0xFFE5CB7A);
  static const Color goldDark = Color(0xFF7A5E1D);
  static const Color bronze = Color(0xFFA8692C);

  // ── Accent ──
  static const Color terracotta = Color(0xFFB5503A);
  static const Color marble = Color(0xFFE8E0D4);

  // ── Text ──
  static const Color textPrimary = Color(0xFFF2EBDF);
  static const Color textSecondary = Color(0xFF9B9183);
  static const Color textDisabled = Color(0xFF5C544B);

  // ── Borders / Dividers ──
  static const Color border = Color(0xFF332D26);
  static const Color borderLight = Color(0xFF403930);
  static const Color divider = Color(0xFF221E18);

  // ── Overlays ──
  static const Color overlay = Color(0xB3000000);
  static const Color overlayLight = Color(0x66000000);
  static const Color overlayGold = Color(0x1AC9A24B);

  // ── Status ──
  static const Color success = Color(0xFF6E9050);
  static const Color warning = Color(0xFFC9A24B);
  static const Color error = Color(0xFFB5503A);

  // ── Gradients ──
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldLight, gold, bronze],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xE6000000)],
  );
}
