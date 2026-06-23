import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color tealPrimary = Color(0xFF0D9488); // Calm, safety, healing (Teal 600)
  static const Color tealLight = Color(0xFFE6F4F1);   // Light teal for accents (Teal 50)
  static const Color blueAccent = Color(0xFF1E40AF);  // Authority, trust, calmness (Blue 800)
  static const Color blueLight = Color(0xFFEFF6FF);   // Blue 50

  // Neutral Backgrounds & Surfaces (Light Mode)
  static const Color bgLight = Color(0xFFF8FAFC);     // Slate 50
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color textLightPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textLightSecondary = Color(0xFF475569); // Slate 600

  // Neutral Backgrounds & Surfaces (Dark Mode)
  static const Color bgDark = Color(0xFF0F172A);      // Slate 900
  static const Color cardDark = Color(0xFF1E293B);    // Slate 800
  static const Color textDarkPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color textDarkSecondary = Color(0xFF94A3B8); // Slate 400

  // Emergency & Status Colors
  static const Color severityCritical = Color(0xFFDC2626); // Crimson Red (Red 600)
  static const Color severityModerate = Color(0xFFD97706); // Warm Amber (Amber 600)
  static const Color severityLow = Color(0xFF059669);      // Emerald Green (Green 600)

  // Border & Grid Colors
  static const Color borderLight = Color(0xFFE2E8F0); // Slate 200
  static const Color borderDark = Color(0xFF334155);  // Slate 700
}
