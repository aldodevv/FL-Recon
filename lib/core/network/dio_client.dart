import 'dart:async';
import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;
  final List<Interceptor> _interceptors = [];

  DioClient({required String baseUrl, Map<String, dynamic>? headers, Duration? connectTimeout, Duration? receiveTimeout, Duration? sendTimeout}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        sendTimeout: sendTimeout ?? const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  // Add multiple interceptors
  void addInterceptors(List<Interceptor> interceptors) {
    _interceptors.addAll(interceptors);
    _dio.interceptors.addAll(interceptors);
  }

  void clearInterceptors() {
    _interceptors.clear();
    _dio.interceptors.clear();
  }

  void updateHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  Future<ResponseResult<T>> request<T>({
    required String path,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    try {
      final res = await _dio.request<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers, sendTimeout: sendTimeout, receiveTimeout: receiveTimeout),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (res.statusCode == 200 && res.data is Map) {
        final statusCode = res.data['statusCode'];
        if (statusCode == 401) {
          return ResponseResult<T>.unauthorized(message: res.data['message']?.toString() ?? 'Unauthorized');
        }
      }

      if (res.statusCode == 401) {
        return ResponseResult<T>.unauthorized(message: res.data?['message']?.toString() ?? 'Unauthorized');
      }

      final parsed = parser != null ? parser(res.data) : res.data as T;
      return ResponseResult<T>.success(data: parsed, rc: res.statusCode, message: res.data is Map ? res.data['message']?.toString() : null);
    } on DioException catch (e) {
      return _handleDioException<T>(e);
    } catch (e, s) {
      return ResponseResult<T>.error(message: e.toString(), exception: e, stackTrace: s);
    }
  }

  Future<ResponseResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    CancelToken? cancelToken,
  }) => request<T>(path: path, method: 'GET', queryParameters: queryParameters, headers: headers, parser: parser, cancelToken: cancelToken);

  Future<ResponseResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) => request<T>(
    path: path,
    method: 'POST',
    data: data,
    queryParameters: queryParameters,
    headers: headers,
    parser: parser,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
  );

  Future<ResponseResult<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    CancelToken? cancelToken,
  }) => request<T>(path: path, method: 'PUT', data: data, queryParameters: queryParameters, headers: headers, parser: parser, cancelToken: cancelToken);

  Future<ResponseResult<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    CancelToken? cancelToken,
  }) => request<T>(path: path, method: 'DELETE', data: data, queryParameters: queryParameters, headers: headers, parser: parser, cancelToken: cancelToken);

  Future<ResponseResult<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    CancelToken? cancelToken,
  }) => request<T>(path: path, method: 'PATCH', data: data, queryParameters: queryParameters, headers: headers, parser: parser, cancelToken: cancelToken);

  ResponseResult<T> _handleDioException<T>(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ResponseResult<T>.connectionTimeout(message: 'Connection timeout', dioException: e);
      case DioExceptionType.sendTimeout:
        return ResponseResult<T>.sendTimeout(message: 'Send timeout', dioException: e);
      case DioExceptionType.receiveTimeout:
        return ResponseResult<T>.receiveTimeout(message: 'Receive timeout', dioException: e);
      case DioExceptionType.badCertificate:
        return ResponseResult<T>.badCertificate(message: 'Bad certificate', dioException: e);
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return ResponseResult<T>.unauthorized(message: e.response?.data?['message']?.toString() ?? 'Unauthorized', dioException: e);
        }
        return ResponseResult<T>.badResponse(message: e.response?.data?['message']?.toString() ?? e.message ?? 'Bad response', rc: statusCode, dioException: e);
      case DioExceptionType.cancel:
        return ResponseResult<T>.cancel(message: 'Request cancelled', dioException: e);
      case DioExceptionType.connectionError:
        return ResponseResult<T>.connectionError(message: 'Connection error', dioException: e);
      case DioExceptionType.unknown:
        return ResponseResult<T>.unknown(message: e.message ?? 'Unknown error', dioException: e);
    }
  }
}

class ResponseResult<T> {
  final T? data;
  final String? message;
  final int? rc;
  final ResultType type;
  final DioException? dioException;
  final Object? exception;
  final StackTrace? stackTrace;

  const ResponseResult._({this.data, this.message, this.rc, required this.type, this.dioException, this.exception, this.stackTrace});

  bool get isSuccess => type == ResultType.success;
  bool get isUnauthorized => type == ResultType.unauthorized;
  bool get isConnectionTimeout => type == ResultType.connectionTimeout;
  bool get isSendTimeout => type == ResultType.sendTimeout;
  bool get isReceiveTimeout => type == ResultType.receiveTimeout;
  bool get isBadCertificate => type == ResultType.badCertificate;
  bool get isBadResponse => type == ResultType.badResponse;
  bool get isCancel => type == ResultType.cancel;
  bool get isConnectionError => type == ResultType.connectionError;
  bool get isUnknown => type == ResultType.unknown;
  bool get isError => type == ResultType.error;

  factory ResponseResult.success({required T data, int? rc, String? message}) =>
      ResponseResult._(data: data, rc: rc, message: message, type: ResultType.success);

  factory ResponseResult.unauthorized({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, rc: 401, type: ResultType.unauthorized, dioException: dioException);

  factory ResponseResult.connectionTimeout({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.connectionTimeout, dioException: dioException);

  factory ResponseResult.sendTimeout({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.sendTimeout, dioException: dioException);

  factory ResponseResult.receiveTimeout({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.receiveTimeout, dioException: dioException);

  factory ResponseResult.badCertificate({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.badCertificate, dioException: dioException);

  factory ResponseResult.badResponse({String? message, int? rc, DioException? dioException}) =>
      ResponseResult._(message: message, rc: rc, type: ResultType.badResponse, dioException: dioException);

  factory ResponseResult.cancel({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.cancel, dioException: dioException);

  factory ResponseResult.connectionError({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.connectionError, dioException: dioException);

  factory ResponseResult.unknown({String? message, DioException? dioException}) =>
      ResponseResult._(message: message, type: ResultType.unknown, dioException: dioException);

  factory ResponseResult.error({String? message, Object? exception, StackTrace? stackTrace}) =>
      ResponseResult._(message: message, type: ResultType.error, exception: exception, stackTrace: stackTrace);
}

enum ResultType { success, unauthorized, connectionTimeout, sendTimeout, receiveTimeout, badCertificate, badResponse, cancel, connectionError, unknown, error }
