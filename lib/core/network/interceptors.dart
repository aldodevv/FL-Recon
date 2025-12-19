import 'package:alice/alice.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RetryInterceptor extends Interceptor {
  final int maxRetries;
  int _retryCount = 0;

  RetryInterceptor({this.maxRetries = 3});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && _retryCount < maxRetries) {
      _retryCount++;
      await Future.delayed(Duration(seconds: _retryCount));

      try {
        final res = await Dio().fetch(err.requestOptions);
        return handler.resolve(res);
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    _retryCount = 0;
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}

class AliceInterceptor extends Interceptor {
  late final AliceDioAdapter _adapter;
  Alice alice = Alice();
  AliceDioAdapter aliceDioAdapter = AliceDioAdapter();

  AliceInterceptor({
    bool enable = true,
    bool showNotification = true,
    bool showInspectorOnShake = true,
    bool showShareButton = true,
    TextDirection? directionality,
    String? notificationIcon,
  }) {
    alice.addAdapter(aliceDioAdapter);
  }
}
