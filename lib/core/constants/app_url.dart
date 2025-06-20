import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppUrl {
  // BASE URL
  static String get appBaseUrl => dotenv.env['APP_PUBLIC_BASE_URL'] ?? '';
  static String get appAssets => dotenv.env['APP_PUBLIC_ASSETS'] ?? '';

  static String get uatBaseUrl => dotenv.env['UAT_PUBLIC_BASE_URL'] ?? '';
  static String get uatAssets => dotenv.env['UAT_PUBLIC_ASSETS'] ?? '';

  static String get devBaseUrl => dotenv.env['DEV_PUBLIC_BASE_URL'] ?? '';
  static String get devAssets => dotenv.env['DEV_PUBLIC_ASSETS'] ?? '';

  // Identity
  static String get identityV1 => dotenv.env['APP_PUBLIC_MENU_IDENTITY_V1_0'] ?? '';
  static String get identityV2 => dotenv.env['APP_PUBLIC_MENU_IDENTITY_V2_0'] ?? '';
  static String get identityV2_1 => dotenv.env['APP_PUBLIC_MENU_IDENTITY_V2_1'] ?? '';
  static String get identityV2_4 => dotenv.env['APP_PUBLIC_MENU_IDENTITY_V2_4'] ?? '';

  // Dashboard
  static String get DashboardV2_1 => dotenv.env['APP_PUBLIC_MENU_DASHBOARD_V2_1'] ?? '';
  static String get DashboardV1_2_0 => dotenv.env['APP_PUBLIC_MENU_DASHBOARD2_V1_2_0'] ?? '';

  // Menu
  static String get language => dotenv.env['APP_PUBLIC_MENU_UI_V1_1_0'] ?? '';

  // Secret key
  static String get testKeyPassword =>
      dotenv.env['APP_PUBLIC_TEST_API_SECRET_PASSWORD'] ?? '';
}
