import 'package:dartz/dartz.dart';
import 'package:recon/core/network/dio_client.dart';
import 'package:recon/core/network/failure_response.dart';

typedef OnUnauthorized = Future<void> Function();
typedef OnShowError = void Function(AppFailure failure);

enum BaseUrl { main, auth }

extension BaseUrlX on BaseUrl {
  String get value {
    switch (this) {
      case BaseUrl.auth:
        return 'https://auth.example.com';
      case BaseUrl.main:
        return 'https://jsonplaceholder.typicode.com';
    }
  }
}

class DioApp {
  late final DioClient _client;

  final OnUnauthorized? onUnauthorized;
  final OnShowError? onShowError;

  DioApp({
    BaseUrl baseUrl = BaseUrl.main,
    Map<String, dynamic>? headers,
    Duration? timeout,
    this.onUnauthorized,
    this.onShowError,
  }) {
    _client = DioClient(
      baseUrl: baseUrl.value,
      headers: headers,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
    );
  }

  Future<Either<AppFailure, T>> request<T>({
    required String path,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
    bool showError = true,
    bool retry = false,
  }) async {
    final result = await _client.request<T>(
      path: path,
      method: method,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      parser: parser,
    );
    if (result.isSuccess) {
      return Right(result.data as T);
    }
    final failure = AppFailure(
      message: result.message ?? 'Unknown error',
      type: result.type,
      rc: result.rc,
    );
    if (result.isUnauthorized) {
      await onUnauthorized?.call();
    }
    if (showError) {
      onShowError?.call(failure);
    }
    if (retry && result.isConnectionError) {
      return request(
        path: path,
        method: method,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        parser: parser,
        retry: false,
      );
    }
    return Left(failure);
  }

  Future<Either<AppFailure, T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
  }) => request<T>(
    path: path,
    method: 'GET',
    queryParameters: query,
    headers: headers,
    parser: parser,
  );

  Future<Either<AppFailure, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    T Function(dynamic)? parser,
  }) => request<T>(path: path, method: 'POST', data: data, headers: headers, parser: parser);
}
