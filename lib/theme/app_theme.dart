import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color brandPrimary = Color(0xFF5A3825);
  static const Color brandSecondary = Color(0xFFEEDAC6);
  static const Color brandAccent = Color(0xFF8BC8A6);

  // Neutral
  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralLight = Color(0xFFFAF9F7);
  static const Color neutralGray1 = Color(0xFFE5E5E5);
  static const Color neutralGray2 = Color(0xFFA1A1A1);
  static const Color neutralGray3 = Color(0xFF6F6F6F);
  static const Color neutralDark = Color(0xFF2A2A2A);

  // Dark mode (reserved)
  static const Color darkBackground = Color(0xFF1B1B1B);
  static const Color darkCard = Color(0xFF262626);
  static const Color darkTextPrimary = Color(0xFFF1F1F1);
  static const Color darkTextSecondary = Color(0xFFA8A8A8);

  // Layout tokens
  static const double padding = 16;
  static const double sectionGap = 24;
  static const double cardRadius = 12;
  static const double buttonRadius = 8;
  static const double imageRadius = 10;
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 72;

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: brandPrimary,
        onPrimary: neutralWhite,
        secondary: brandSecondary,
        onSecondary: neutralDark,
        surface: neutralWhite,
        onSurface: neutralDark,
        background: neutralLight,
        onBackground: neutralDark,
        error: const Color(0xFFE53935),
        onError: neutralWhite,
      ),
      scaffoldBackgroundColor: neutralLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: neutralWhite,
        foregroundColor: neutralDark,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: appBarHeight,
      ),
      cardTheme: const CardTheme(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
      shadowColor: Colors.black.withOpacity(0.06),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: brandPrimary,
          foregroundColor: neutralWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          foregroundColor: brandPrimary,
          side: const BorderSide(color: brandPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
          borderSide: const BorderSide(color: neutralGray1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
          borderSide: const BorderSide(color: brandPrimary),
        ),
        filled: true,
        fillColor: neutralWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: brandPrimary,
        unselectedItemColor: neutralGray3,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );

    final textTheme = GoogleFonts.pretendardTextTheme().copyWith(
      displayLarge: GoogleFonts.pretendard(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: neutralDark,
      ),
      displayMedium: GoogleFonts.pretendard(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: neutralDark,
      ),
      displaySmall: GoogleFonts.pretendard(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: neutralDark,
      ),
      bodyLarge: GoogleFonts.pretendard(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: neutralDark,
      ),
      bodyMedium: GoogleFonts.pretendard(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: neutralDark,
      ),
      bodySmall: GoogleFonts.pretendard(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: neutralDark,
      ),
      labelSmall: GoogleFonts.pretendard(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: neutralGray3,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
    );
  }
}

