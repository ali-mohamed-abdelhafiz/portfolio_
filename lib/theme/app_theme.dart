import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FA); // white/soft gray
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF2D3748);
  static const Color lightPrimary = Color(0xFF0097A7); // Cyan/Teal
  static const Color lightSecondary = Color(0xFFE2E8F0);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A); // True Dark Slate (Modern)
  static const Color darkSurface = Color(0xFF1E293B); // Elevated Dark Slate
  static const Color darkText = Color(0xFFF8FAFC); // Soft readable white
  static const Color darkPrimary = Color(0xFF06B6D4); // Cyan/Teal modern accent
  static const Color darkSecondary = Color(0xFF334155); // Zinc grey border/sub details

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightSurface,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightPrimary,
        surface: lightSurface,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(color: lightText, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.inter(color: lightText, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.inter(color: lightText),
        bodyMedium: GoogleFonts.inter(color: lightText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkSurface,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkPrimary,
        surface: darkSurface,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(color: darkText, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.inter(color: darkText, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.inter(color: darkText),
        bodyMedium: GoogleFonts.inter(color: darkText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    );
  }
}
