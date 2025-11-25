class MainConst {
  // Base URL
  static const String baseUrlKey = 'BASE_URL';
  static const String devUrlKey = 'DEV_URL';
  static const String stagingUrlKey = 'STAGING_URL';
  static const String pilotUrlKey = 'PILOT_URL';
  static const String prodUrlKey = 'PROD_URL';

  static const String ipificationShaKey = 'IPIFICATION_SHA';
  static const String telkomselShaKey = 'TELKOMSEL_SHA';
  static const String stagingShaKey = 'STAGING_SHA';
  static const String pilotShaKey = 'PILOT_SHA';
  static const String feedbackOptionsKey = 'FEEDBACK_OPTIONS_';

  static const String devUrlOdin = 'DEV_URL_ODIN';

  static const String valkyrieMiddlewarePath = '/business-service';
  static const String odinMiddlewarePath = '/identity';
  static const String heimdallMiddlewarePath = '/totp-service';
  static const String baldurMiddlewarePath = '/transaction-service';

  static const String withoutInterceptor = 'wI';
  static const String withoutToken = 'wT';
  static const String withoutEncrypt = 'wE';
  static const String withoutContentType = 'wCT';
  static const String qlolaHeaders = 'qH';

  static const String route = 'route';
  static const String corpId = 'corpId';

  static const String rcType = 'rcType';
  static const String rcTypeGeneral = 'General';
  static const String rcTypeLogin = 'Login';
  static const String rcTypeMobileActivation = 'MobileActivation';
  static const String rcTypeMobileApproval = 'MobileApproval';
  static const String rcTypeLimitManagement = 'LimitManagement';
  static const String rcTypeMobileIdCard = 'MobileIDCard';
  static const String rcTypeComplainHandling = 'Complaint';
  static const String rcTypeChangePassword = 'ChangePassword';
  static const String rcTypeTotp = 'Totp';

  static const String rcSuccess = '200';
  static const String rcUserBlocked = 'CL03';
  static const String rcBlocked = 'CL04';
  static const String rcUserFirstLogin = 'US11';
  static const String rcUserBiometricFailed = 'US12';
  static const String rcUnauthorized = 'AUTH01';
  static const String rcPhoneWrong = 'TVH02';
  static const String rcDeviceFail = 'TVD01';
  static const String rcDeviceWrong = 'TVD02';
  static const String rcDeviceExpired = 'TVD03';
  static const String rcDeviceMaxAttempt = 'TVD04';
  static const String rcUserActivated = 'UAC01';
  static const String rcUserNotActivated = 'UAC02';
  static const String rcUserMaxDailyLimit = 'UAC03';
  static const String rcPinWrong = 'TVP01';
  static const String rcMaxPinAttempt = 'TVP02';
  static const String rcWeakPin = 'TVP03';
  static const String rcPinOldSameNewPin = 'TVP04';
  static const String rcMaxOTPAttempt = 'OTP04';
  static const String rcMaxUserRequest = 'TVE01';
  static const String rcMaxAttempts2 = 'TVE02';
  static const String rcMaxResend = 'TVE03';
  static const String rcResponseError = 'RES01';
  static const String rcVersionNotSupported = 'VER01';
  static const String rcTokenExpired = 'TK03';
  static const String rcFailedIdCard = 'ID01';
  static const String rcMaxAttemptIdCard = 'ID02';
  static const String rcLivenessMaxAttempt = 'LV01';
  static const String rcLivenessInProgress = 'LV02';
  static const String rcLivenessInFailed = 'LV03';
  static const String rcVidaMaxAttempt = 'FC01';
  static const String rcVidaFailed = 'FC02';

  static const String rcOTPWrong = 'OTP01';
  static const String rcOTPExpired = 'OTP02';

  static const String rcVerifyPassword = 'AUTH99';
  static const String rcAccountBlock = 'AUTH98';

  static const String rcEncryptError = 'APP01';
  static const String rcDecryptError = 'APP02';
  static const String rcGetRCError = 'APP03';
  static const String rcAppError = 'APP99';

  static const String rcChangePasswordMaxAttempt = 'CPW04';
  static const String rcChangePasswordInvalid = 'CPW03';
  static const String rcChangePasswordOtpExpired = 'OTP02';

  static const int signerRole = 3;

  static const String localeEn = 'en';
  static const String localeId = 'id';

  static const String headerAuthorization = 'Authorization';
  static const String headerAcceptLanguage = 'Accept-Language';
  static const String headerIpAddress = 'X-Forwarded-For';

  static const String storageClientId = 'client_id';
  static const String storageUserId = 'user_id';

  static const String xEnv = 'X-Env';
}
