import 'package:flutter/material.dart';

class AppColors {
  // =================== BLUE (Brand) ===================
  static const blue100 = Color(0xFF0C3A83);
  static const blue90  = Color(0xFF1762CA);
  static const blue80  = Color(0xFF1B6CCE);
  static const blue70  = Color(0xFF136CCC);
  static const blue60  = Color(0xFF1274CB);
  static const blue50  = Color(0xFF1E87D6);
  static const blue40  = Color(0xFF3DA2F2);
  static const blue30  = Color(0xFF6AC2F7);
  static const blue20  = Color(0xFFBDE8FA);
  static const blue10  = Color(0xFFD0F1FF);

  // ================ ORANGE (Brand Secondary) ============
  static const orange100 = Color(0xFFCA5000);
  static const orange90  = Color(0xFFFA7A00);
  static const orange80  = Color(0xFFFF9933);
  static const orange70  = Color(0xFFFFA940);
  static const orange60  = Color(0xFFFFB866);
  static const orange50  = Color(0xFFFFC78F);
  static const orange40  = Color(0xFFFFD9B2);
  static const orange30  = Color(0xFFFFE5C0);
  static const orange20  = Color(0xFFFFEDCC);
  static const orange10  = Color(0xFFFFF5E5);

  // ================ BLUE by BRI ========================
  static const blueBRI100 = Color(0xFF003172);
  static const blueBRI90  = Color(0xFF00439C);
  static const blueBRI80  = Color(0xFF0056CB);
  static const blueBRI70  = Color(0xFF0070E7);
  static const blueBRI60  = Color(0xFF168EFF);
  static const blueBRI50  = Color(0xFF29A9FF);
  static const blueBRI40  = Color(0xFF52C2FF);
  static const blueBRI30  = Color(0xFF79D6FF);
  static const blueBRI20  = Color(0xFFA6E6FF);
  static const blueBRI10  = Color(0xFFCDEBFF);

  // ================ PURPLE by Ceria =====================
  static const purpleCeria100 = Color(0xFF8000B5);
  static const purpleCeria90  = Color(0xFFA700DE);
  static const purpleCeria80  = Color(0xFFB500DC);
  static const purpleCeria70  = Color(0xFFD000F2);
  static const purpleCeria60  = Color(0xFFE14CFF);
  static const purpleCeria50  = Color(0xFFEF6FFF);
  static const purpleCeria40  = Color(0xFFF7A4FF);
  static const purpleCeria30  = Color(0xFFF4BAFF);
  static const purpleCeria20  = Color(0xFFEBD3FF);
  static const purpleCeria10  = Color(0xFFF6EDFF);

  // ==================== GREEN ============================
  static const green100 = Color(0xFF186A00);
  static const green90  = Color(0xFF218C14);
  static const green80  = Color(0xFF27AB1A);
  static const green70  = Color(0xFF2BC11C);
  static const green60  = Color(0xFF47C362);
  static const green50  = Color(0xFF6BD89A);
  static const green40  = Color(0xFF92E4AD);
  static const green30  = Color(0xFFA4EBC2);
  static const green20  = Color(0xFFC2F1D6);
  static const green10  = Color(0xFFE7FBEB);

  // ==================== YELLOW ===========================
  static const yellow100 = Color(0xFFFFB100);
  static const yellow90  = Color(0xFFFFC640);
  static const yellow80  = Color(0xFFFFD15C);
  static const yellow70  = Color(0xFFFFD973);
  static const yellow60  = Color(0xFFFFDF95);
  static const yellow50  = Color(0xFFFFE7B7);
  static const yellow40  = Color(0xFFFFF0CC);
  static const yellow30  = Color(0xFFFFF4DB);
  static const yellow20  = Color(0xFFFFF9EB);
  static const yellow10  = Color(0xFFFFFDF5);

  // ==================== RED ==============================
  static const red100 = Color(0xFFB10000);
  static const red90  = Color(0xFFCE1414);
  static const red80  = Color(0xFFED1F1F);
  static const red70  = Color(0xFFEE3700);
  static const red60  = Color(0xFFF15D5D);
  static const red50  = Color(0xFFF48A8A);
  static const red40  = Color(0xFFF6A7A7);
  static const red30  = Color(0xFFF7C0C0);
  static const red20  = Color(0xFFF9D9D9);
  static const red10  = Color(0xFFFCE7E7);

  // ==================== NEUTRALS =========================
  // Base
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  // Light Neutrals
  static const lightNeutral80 = Color(0xFF777777);
  static const lightNeutral70 = Color(0xFF949494);
  static const lightNeutral60 = Color(0xFFB2B2B2);
  static const lightNeutral50 = Color(0xFFD4D4D4);
  static const lightNeutral40 = Color(0xFFEAEAEA);
  static const lightNeutral30 = Color(0xFFF4F4F4);
  static const lightNeutral20 = Color(0xFFF8F8F8);
  static const lightNeutral10 = Color(0xFFFBFBFB);

  // Dark Neutrals
  static const darkNeutral80 = Color(0xFF292929);
  static const darkNeutral70 = Color(0xFF383838);
  static const darkNeutral60 = Color(0xFF434343);
  static const darkNeutral50 = Color(0xFF525252);
  static const darkNeutral40 = Color(0xFF666666);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.blueBRI80,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blueBRI80,
      foregroundColor: AppColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
    cardColor: AppColors.lightNeutral10,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueBRI80,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkNeutral80,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkNeutral70,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        color: AppColors.blueBRI80,
        fontWeight: FontWeight.bold,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightNeutral30,
      selectedColor: AppColors.blue30,
      disabledColor: AppColors.lightNeutral50,
      labelStyle: const TextStyle(color: AppColors.darkNeutral80),
      secondaryLabelStyle: const TextStyle(color: AppColors.blueBRI100),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      brightness: Brightness.light,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.blueBRI80,
      secondary: AppColors.orange70,
      error: AppColors.red70,
      background: AppColors.white,
      surface: AppColors.lightNeutral30,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onError: AppColors.white,
      onBackground: AppColors.darkNeutral80,
      onSurface: AppColors.darkNeutral80,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkNeutral80,
    primaryColor: AppColors.blueBRI50,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkNeutral70,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: AppColors.darkNeutral60,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.lightNeutral10,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.lightNeutral20,
        fontSize: 14,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.blueBRI50,
      secondary: AppColors.orange60,
      error: AppColors.red60,
      background: AppColors.darkNeutral80,
      surface: AppColors.darkNeutral60,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onError: AppColors.white,
      onBackground: AppColors.white,
      onSurface: AppColors.white,
    ),
  );
}