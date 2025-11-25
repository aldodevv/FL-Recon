// network/dio_client.dart
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recon/core/constants/app_const.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/core/network/dio_const.dart';
import 'package:recon/core/network/failure_response.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/flavors.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

class DioHeaders {
  static const authorization = 'Authorization';
  static const bearer = 'Bearer';
}

extension DioAppX on DioApp {
  Future<Either<ResponseFailed, Response<T>>> safeRequest<T>(
    Future<Response<T>> Function() requestFn,
  ) async {
    try {
      final response = await requestFn();
      return Right(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _handleUnauthorized();
      }
      return Left(ResponseFailed.fromDioError(e));
    } catch (e) {
      return Left(
        ResponseFailed(
          message: e.toString(),
          statusCode: null,
          isUnauthorized: false,
        ),
      );
    }
  }
}

class DioApp {
  static DioApp? _instance;
  static DioApp get instance => _instance ??= DioApp._();

  static String get _baseUrl {
    switch (F.appFlavor) {
      case Flavor.dev:
        return AppConst.devBaseUrl;
      case Flavor.uat:
        return AppConst.uatBaseUrl;
      case Flavor.prod:
        return AppConst.appBaseUrl;
    }
  }

  late Dio dio;
  final Logger _logger = Logger();

  DioApp._() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: DioContentType.json,
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await Utils.storageSecure.read(key: 'token');
          final hasToken = token != null && token.isNotEmpty;

          final isPrivate = options.path.contains('/private/');
          final isPublic = options.path.contains('/public/');

          if (isPrivate && hasToken) {
            options.headers[DioHeaders.authorization] =
                '${DioHeaders.bearer} $token';
          } else if (isPublic) {
            options.headers.remove(DioHeaders.authorization);
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          handler.next(response);
        },
        onError: (DioException e, handler) async {
          _logError(e);
          handler.next(e);
        },
      ),
    );
  }

  /// Gunakan ini untuk memanggil Dio request dengan error handling
  Future<Either<ResponseFailed, Response<T>>> safeRequest<T>(
    Future<Response<T>> Function() requestFn,
  ) async {
    try {
      final response = await requestFn();
      return Right(response);
    } on DioException catch (e) {
      return _handleException(e);
    } catch (e) {
      return Left(
        ResponseFailed(
          message: e.toString(),
          statusCode: null,
          isUnauthorized: false,
        ),
      );
    }
  }

  /// Handler untuk error dari Dio
  Future<Either<ResponseFailed, Response<T>>> _handleException<T>(
    DioException error,
  ) async {
    final responseFailed = ResponseFailed.fromDioError(error);
    final mainContext =
        getIt<GlobalKey<NavigatorState>>().currentState!.context;
    // Unauthorized (401)
    if (responseFailed.isUnauthorized) {
      await Utils.storageSecure.delete(key: 'token');
      if (mainContext.mounted) {
        mainContext.router.replaceAll([const SigninRoute()]);
      }
    }

    // Show error bottom sheet
    if (mainContext.mounted) {
      showModalBottomSheet(
        context: mainContext,
        builder:
            (_) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(responseFailed.message),
            ),
      );
    }

    return Left(responseFailed);
  }

  void _logResponse(Response response) {
    try {
      final uri = response.requestOptions.uri;
      final method = response.requestOptions.method;
      final status = response.statusCode;
      final headers = response.headers.map;
      final responseData = response.data;

      _logger.i(
        '📥 RESPONSE: [$method] $uri\n'
        'Status: $status\n'
        'Headers: $headers\n'
        'Payload: ${_prettyPrint(responseData)}',
      );
    } catch (e) {
      _logger.e('Error logging response: $e');
    }
  }

  Future<void> _handleUnauthorized() async {
    _logger.w('401 detected - clearing token');
    await Utils.storageSecure.delete(key: 'token');
  }

  void _logError(DioException error) {
    try {
      final uri = error.requestOptions.uri;
      final method = error.requestOptions.method;
      final status = error.response?.statusCode;
      final data = error.response?.data;
      final message = error.message;

      _logger.e(
        '❌ ERROR: [$method] $uri\n'
        'Status: $status\n'
        'Message: $message\n'
        'Error Data: ${_prettyPrint(data)}',
      );
    } catch (e) {
      _logger.e('Error logging Dio error: $e');
    }
  }

  String _prettyPrint(dynamic data) {
    try {
      if (data is String) return data;
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (e) {
      return data.toString();
    }
  }

  post(
    String s, {
    required Map<String, Object> data,
    required Options options,
  }) {}

  get(String s, {required Options options}) {}
}
