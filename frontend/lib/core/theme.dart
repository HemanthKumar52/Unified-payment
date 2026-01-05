import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
    primaryColor: const Color(0xFF6366F1), // Indigo 500
    cardColor: const Color(0xFF1E293B), // Slate 800
    textTheme: GoogleFonts.outfitTextTheme(
      ThemeData.dark().textTheme,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6366F1),
      secondary: Color(0xFFEC4899), // Pink 500
      surface: Color(0xFF1E293B),
    ),
    useMaterial3: true,
  );
}
