import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppImages {
  static final String _base = '${dotenv.env['APP_PUBLIC_ASSETS']}/mobile/images';

  // Logo - Network
  static final String logoQlolaWhite = '$_base/logo_white.png';
  static final String logoQlola = '$_base/logo_qlola.png';
  static final String logoQlolaShadow = '$_base/logo_qlola_shadow.png';
  static final String logoBriPutih = '$_base/logo_BRI_white.png';
  static final String logoQlolaTransparent = '$_base/logo_qlola_transparent.png';
  static final String logoQlolaPng = '$_base/logo.png';

  // Background - Network
  static final String backgroundHeaderHome = '$_base/headerBg.png';
  static final String backgroundMockupOne = '$_base/mockup1.png';
  static final String backgroundMockupTwo = '$_base/mockup2.png';
  static final String backgroundMockupThree = '$_base/mockup3.png';
  static final String backgroundMockupFour = '$_base/mockup4.png';
  static final String backgroundCashManagement = '$_base/bg_cash_no_icon.png';
  static final String backgroundQlolaHp = '$_base/qlola-bg.png';
  static final String backgroundQlolaTablet = '$_base/qlola-bg-tab.png';
  static final String backgroundQlolaTabletLandscape = '$_base/qlola-bg-landscape.png';
  static final String backgroundStickyHeader = '$_base/sticky_header.png';
  static final String backgroundThumbnail1 = '$_base/thumbnail1.png';
  static final String backgroundThumbnail2 = '$_base/thumbnail2.png';
  static final String backgroundThumbnail3 = '$_base/thumbnail3.png';
  static final String backgroundThumbnail4 = '$_base/thumbnail4.png';
  static final String backgroundThumbnail5 = '$_base/thumbnail5.png';
  static final String backgroundThumbnail6 = '$_base/thumbnail6.png';
  static final String backgroundThumbnail7 = '$_base/thumbnail7.png';
  static final String backgroundThumbnail8 = '$_base/thumbnail8.png';

  // Logo - Local Assets
  static const String localLogoQlolaWhite = 'assets/images/logo_white.png';
  static const String localLogoQlola = 'assets/images/logo_qlola.png';
  static const String localLogoQlolaShadow = 'assets/images/logo_qlola_shadow.png';
  static const String localLogoBriPutih = 'assets/images/logo_white.png';
  static const String localLogoQlolaTransparent = 'assets/images/logo_qlola_transparent.png';
  static const String localLogoQlolaPng = 'assets/images/logo.png';

  // Background - Local Assets
  static const String localBackgroundHeaderHome = 'assets/images/headerBg.png';
  static const String localBackgroundQlolaHp = 'assets/images/qlola-bg.png';
  static const String localBackgroundQlolaTablet = 'assets/images/qlola-bg-tab.png';
  static const String localBackgroundQlolaTabletLandscape = 'assets/images/qlola-bg-landscape.png';
  static const String localBackgroundStickyHeader = 'assets/images/sticky_header.png';
  static const String localLostConnection = 'assets/images/ic_lostconnection.png';
}
