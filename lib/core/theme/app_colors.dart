import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0B0E17);
  static const Color surface = Color(0xFF141824);
  static const Color surfaceLight = Color(0xFF1E2436);
  static const Color cardBorder = Color(0xFF2A324B);

  // Accents
  static const Color primary = Color(0xFF00F2FE);
  static const Color primaryGlow = Color(0x3300F2FE);
  static const Color secondary = Color(0xFF7F00FF);
  static const Color secondaryGlow = Color(0x337F00FF);

  // Status Indicators
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFB300);
  static const Color danger = Color(0xFFFF3366);
  static const Color info = Color(0xFF29B6F6);

  // Text
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00F2FE), Color(0xFF4FACFE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF161A2B), Color(0xFF0E111C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xFFFF3366), Color(0xFFFF6B6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
