import 'package:dio/dio.dart';

class ResponseFailed {
  final String message;
  final int? statusCode;
  final bool isUnauthorized;

  ResponseFailed({
    required this.message,
    this.statusCode,
    this.isUnauthorized = false,
  });

  factory ResponseFailed.fromDioError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final is401 = statusCode == 401;

    return ResponseFailed(
      message: response?.data?['message']?.toString() ?? error.message ?? 'Unknown error',
      statusCode: statusCode,
      isUnauthorized: is401,
    );
  }
}
