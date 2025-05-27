// network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:recon/core/network/dio_constants.dart';
import 'package:recon/flavors.dart';
import 'package:recon/core/utils/utils.dart';

class DioApp {
  static DioApp? _instance;
  static DioApp get instance => _instance ??= DioApp._();

  late Dio _dio;
  late Logger _logger;

  DioApp._() {
    _setupLogger();
    _setupDio();
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupLogger() {
    _logger = Logger(
      filter: ProductionFilter(),
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 3,
        lineLength: 75,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      output: ConsoleOutput(),
    );
  }

  void _setupDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: DioConfig.connectTimeout),
        receiveTimeout: const Duration(seconds: DioConfig.receiveTimeout),
        sendTimeout: const Duration(seconds: DioConfig.sendTimeout),
        headers: {
          DioHeaders.contentType: DioContentType.json,
          DioHeaders.accept: DioContentType.json,
          DioHeaders.userAgent: _getUserAgent(),
          DioHeaders.platform: _getPlatform(),
          DioHeaders.appVersion: _getAppVersion(),
        },
        responseType: ResponseType.json,
        followRedirects: true,
        maxRedirects: 3,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  String _getBaseUrl() {
    switch (F.appFlavor) {
      case Flavor.dev:
        return const String.fromEnvironment(
          'DEV_BASE_URL',
          defaultValue: 'https://qlola.dev.bri.co.id/api',
        );
      case Flavor.uat:
        return const String.fromEnvironment(
          'UAT_BASE_URL',
          defaultValue: 'https://qlola-uat.dev.bri.co.id/api',
        );
      case Flavor.prod:
        return const String.fromEnvironment(
          'PROD_BASE_URL',
          defaultValue: 'https://qlola.bri.co.id/api',
        );
    }
  }

  String _getUserAgent() => 'recon/${_getAppVersion()} ${_getPlatform()}';
  String _getPlatform() => defaultTargetPlatform.name;
  String _getAppVersion() =>
      const String.fromEnvironment('APP_VERSION', defaultValue: '1.0.0');

  void _setupInterceptors() {
    // Auth Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final isPublicEndpoint = options.path.contains('/public/');
          if (!isPublicEndpoint) {
            final token = await Utils.storageSecure.read(key: 'token');
            if (token != null) {
              options.headers[DioHeaders.authorization] =
                  '${DioHeaders.bearer} $token';
            }
          }
          options.headers[DioHeaders.requestId] = _generateRequestId();
          options.headers[DioHeaders.timestamp] =
              DateTime.now().millisecondsSinceEpoch.toString();
          handler.next(options);
        },
      ),
    );

    // Loading Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // LoadingService.show();
          handler.next(options);
        },
        onResponse: (response, handler) {
          // LoadingService.hide();
          handler.next(response);
        },
        onError: (error, handler) {
          // LoadingService.hide();
          handler.next(error);
        },
      ),
    );

    // Logging Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logRequest(options);
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          handler.next(response);
        },
        onError: (error, handler) {
          _logError(error);
          handler.next(error);
        },
      ),
    );

    // Error Handling Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == DioHttpStatus.unauthorized) {
            await _handleUnauthorized();
            handler.next(error);
            return;
          }

          if (error.response != null &&
              error.response!.statusCode! >= DioHttpStatus.methodNotAllowed) {
            _handleServerError(error);
          }

          handler.next(error);
        },
      ),
    );

    // Retry Interceptor
    _dio.interceptors.add(RetryInterceptor());
  }

  void _logRequest(RequestOptions options) {
    if (!kDebugMode) return;

    _logger.i('''
┌── REQUEST ────────────────────────────────────────────────────────────────
│ ${options.method.toUpperCase()} ${options.uri}
├── Headers:
${_formatHeaders(options.headers)}
├── Query Parameters:
${_formatMap(options.queryParameters)}
├── Body:
${_formatData(options.data)}
└────────────────────────────────────────────────────────────────────────────
''');
  }

  void _logResponse(Response response) {
    if (!kDebugMode) return;

    _logger.i('''
┌── RESPONSE ───────────────────────────────────────────────────────────────
│ ${response.statusCode} ${response.statusMessage}
│ ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.uri}
├── Headers:
${_formatHeaders(response.headers.map)}
├── Data:
${_formatData(response.data)}
└────────────────────────────────────────────────────────────────────────────
''');
  }

  void _logError(DioException error) {
    if (!kDebugMode) return;

    _logger.e('''
┌── ERROR ──────────────────────────────────────────────────────────────────
│ ${error.response?.statusCode ?? 'UNKNOWN'} ${error.message}
│ ${error.requestOptions.method.toUpperCase()} ${error.requestOptions.uri}
├── Error Type: ${error.type}
├── Response Data:
${_formatData(error.response?.data)}
├── Stack Trace:
${error.stackTrace.toString().split('\n').take(5).join('\n')}
└────────────────────────────────────────────────────────────────────────────
''');
  }

  String _formatHeaders(Map<String, dynamic> headers) {
    return headers.entries.map((e) => '│   ${e.key}: ${e.value}').join('\n');
  }

  String _formatMap(Map<String, dynamic> map) {
    if (map.isEmpty) return '│   (empty)';
    return map.entries.map((e) => '│   ${e.key}: ${e.value}').join('\n');
  }

  String _formatData(dynamic data) {
    if (data == null) return '│   (null)';

    final String dataStr = data.toString();
    if (dataStr.length > 500) {
      return '│   ${dataStr.substring(0, 500)}...';
    }

    return dataStr.split('\n').map((line) => '│   $line').join('\n');
  }

  Future<void> _handleUnauthorized() async {
    _logger.w('Unauthorized access - clearing auth data');
    // await AuthService.clearAuth();
    // ErrorService.showUnauthorizedDialog();
  }

  void _handleServerError(DioException error) {
    _logger.e('Server error: ${error.response?.statusCode}');
    // ErrorService.showGeneralError(
    //   message: _getErrorMessage(error),
    //   statusCode: error.response?.statusCode,
    // );
  }

  // String _getErrorMessage(DioException error) {
  //   switch (error.response?.statusCode) {
  //     case DioHttpStatus.methodNotAllowed:
  //       return DioMessages.generalError;
  //     case DioHttpStatus.internalServerError:
  //       return DioMessages.internalServerError;
  //     case DioHttpStatus.serviceUnavailable:
  //       return DioMessages.serviceUnavailable;
  //     case DioHttpStatus.gatewayTimeout:
  //       return DioMessages.networkTimeout;
  //     default:
  //       return DioMessages.generalError;
  //   }
  // }

  String _generateRequestId() {
    return '${DateTime.now().millisecondsSinceEpoch}-${UniqueKey().toString().substring(0, 8)}';
  }

  // Utility methods untuk custom requests
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

// Retry Interceptor untuk auto retry pada network error
class RetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] == null) {
      err.requestOptions.extra['retryCount'] = 0;
    }

    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
    if (retryCount < DioConfig.maxRetries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future.delayed(
        Duration(
          milliseconds: (DioConfig.retryDelay * (retryCount + 1)).toInt(),
        ),
      );
      try {
        final response = await DioApp.instance.dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Continue with original error if retry fails
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
