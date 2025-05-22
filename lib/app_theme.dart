import 'package:flutter/material.dart';
import 'package:recon/constant/colors_const.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: MainColors.white,
    primaryColor: MainColors.blueBRI80,
    appBarTheme: const AppBarTheme(
      backgroundColor: MainColors.blueBRI80,
      foregroundColor: MainColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MainColors.white,
      ),
    ),
    cardColor: MainColors.lightNeutral10,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MainColors.blueBRI80,
        foregroundColor: MainColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: MainColors.darkNeutral80,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: MainColors.darkNeutral70,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        color: MainColors.blueBRI80,
        fontWeight: FontWeight.bold,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: MainColors.lightNeutral30,
      selectedColor: MainColors.blue30,
      disabledColor: MainColors.lightNeutral50,
      labelStyle: const TextStyle(color: MainColors.darkNeutral80),
      secondaryLabelStyle: const TextStyle(color: MainColors.blueBRI100),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      brightness: Brightness.light,
    ),
    colorScheme: ColorScheme.light(
      primary: MainColors.blueBRI80,
      secondary: MainColors.orange70,
      error: MainColors.red70,
      background: MainColors.white,
      surface: MainColors.lightNeutral30,
      onPrimary: MainColors.white,
      onSecondary: MainColors.white,
      onError: MainColors.white,
      onBackground: MainColors.darkNeutral80,
      onSurface: MainColors.darkNeutral80,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: MainColors.darkNeutral80,
    primaryColor: MainColors.blueBRI50,
    appBarTheme: const AppBarTheme(
      backgroundColor: MainColors.darkNeutral70,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: MainColors.darkNeutral60,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: MainColors.lightNeutral10,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: MainColors.lightNeutral20,
        fontSize: 14,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: MainColors.blueBRI50,
      secondary: MainColors.orange60,
      error: MainColors.red60,
      background: MainColors.darkNeutral80,
      surface: MainColors.darkNeutral60,
      onPrimary: MainColors.white,
      onSecondary: MainColors.white,
      onError: MainColors.white,
      onBackground: MainColors.white,
      onSurface: MainColors.white,
    ),
  );
}