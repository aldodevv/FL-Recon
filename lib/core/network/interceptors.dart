import 'package:dio/dio.dart';

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
    return err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout || err.type == DioExceptionType.connectionError;
  }
}
