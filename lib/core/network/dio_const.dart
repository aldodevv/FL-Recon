// constants/http_constants.dart
class DioHttpStatus {
  static const int success = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int tooManyRequests = 429;
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}

class DioContentType {
  static const String json = 'application/json';
  static const String formData = 'multipart/form-data';
  static const String urlEncoded = 'application/x-www-form-urlencoded';
  static const String xml = 'application/xml';
  static const String textPlain = 'text/plain';
  static const String textHtml = 'text/html';
  static const String octetStream = 'application/octet-stream';
  static const String pdf = 'application/pdf';
  static const String jpeg = 'image/jpeg';
  static const String png = 'image/png';
}

class DioMessages {
  // Success Messages
  static const String loginSuccessful = 'Login successful';
  static const String logoutSuccessful = 'Logout successful';
  static const String dataLoadedSuccessfully = 'Data loaded successfully';
  static const String dataSavedSuccessfully = 'Data saved successfully';
  static const String dataUpdatedSuccessfully = 'Data updated successfully';
  static const String dataDeletedSuccessfully = 'Data deleted successfully';
  static const String otpSentSuccessfully = 'The OTP has been successfully sent';
  static const String otpVerifiedSuccessfully = 'OTP verified successfully';
  static const String passwordResetSuccessful = 'Password reset successful';
  static const String registrationSuccessful = 'Registration successful';

  // Info Messages
  static const String newDeviceDetected = 'New device detected!';
  static const String accountLocked = 'Account temporarily locked';
  static const String sessionExpired = 'Session expired, please login again';
  static const String dataNotFound = 'Data not found';
  static const String noInternetConnection = 'No internet connection';
  static const String syncInProgress = 'Synchronization in progress';

  // Error Messages
  static const String incorrectUsernameOrPassword = 'Incorrect Username or Password';
  static const String userDoesNotHaveAccess = 'User does not have access to the mobile menu';
  static const String invalidCredentials = 'Invalid credentials provided';
  static const String accountNotActivated = 'Account not activated';
  static const String emailAlreadyExists = 'Email address already exists';
  static const String usernameAlreadyExists = 'Username already exists';
  static const String weakPassword = 'Password is too weak';
  static const String invalidEmailFormat = 'Invalid email format';
  static const String invalidPhoneNumber = 'Invalid phone number format';
  static const String fieldRequired = 'This field is required';
  static const String minimumCharacterRequired = 'Minimum 8 characters required';
  static const String passwordMismatch = 'Password confirmation does not match';

  // System Error Messages
  static const String c404 = 'C404';
  static const String internalServerError = 'Internal server error, Please come back later';
  static const String serviceUnavailable = 'Service temporarily unavailable';
  static const String networkTimeout = 'Network timeout, please try again';
  static const String generalError = 'Something went wrong, please try again';
  static const String maintenanceMode = 'System under maintenance';
  static const String tooManyRequests = 'Too many requests, please wait';
  static const String serverOverloaded = 'Server overloaded, please try again later';

  // Validation Messages
  static const String invalidOtp = 'Invalid OTP code';
  static const String otpExpired = 'OTP code has expired';
  static const String maxAttemptsReached = 'Maximum attempts reached';
  static const String fileSizeTooLarge = 'File size too large';
  static const String invalidFileFormat = 'Invalid file format';
  static const String uploadFailed = 'File upload failed';

  // Dynamic Messages
  static String deviceBlocked(String username, String duration) =>
      'Device $username is still blocked for $duration';
  
  static String remainingAttempts(int attempts) =>
      'Remaining attempts: $attempts';
  
  static String fileUploaded(String filename) =>
      'File $filename uploaded successfully';
  
  static String dataExpired(String dataType) =>
      '$dataType data has expired';
  
  static String recordsFound(int count) =>
      '$count records found';
  
  static String itemsSelected(int count) =>
      '$count items selected';
  
  static String syncCompleted(DateTime timestamp) =>
      'Sync completed at ${timestamp.toString()}';
}

class DioHeaders {
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String userAgent = 'User-Agent';
  static const String deviceId = 'X-Device-ID';
  static const String appVersion = 'X-App-Version';
  static const String platform = 'X-Platform';
  static const String timestamp = 'X-Timestamp';
  static const String signature = 'X-Signature';
  static const String requestId = 'X-Request-ID';
  static const String sessionId = 'X-Session-ID';
  static const String language = 'Accept-Language';
  static const String cacheControl = 'Cache-Control';
  static const String ifModifiedSince = 'If-Modified-Since';
  static const String etag = 'ETag';
}

class DioEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';

  // User
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String changePassword = '/user/change-password';
  static const String deleteAccount = '/user/delete';

  // Common endpoints yang sering dipakai
  static const String dashboard = '/dashboard';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String upload = '/upload';
  static const String download = '/download';
}

class DioConfig {
  static const int connectTimeout = 50; // seconds
  static const int receiveTimeout = 30; // seconds
  static const int sendTimeout = 30; // seconds
  static const int maxRetries = 3;
  static const int retryDelay = 1000; // milliseconds
  static const int cacheMaxAge = 300; // seconds (5 minutes)
  static const int uploadChunkSize = 1024 * 1024; // 1MB chunks
}