import 'package:flutter/material.dart';
import 'package:recon/constant/colors_const.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: MainColors.lightNeutral30,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: MainColors.darkNeutral80,
  );
}
