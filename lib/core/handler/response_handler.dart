import 'package:dio/dio.dart';
import 'package:recon/core/constants/dio_const.dart';

class ResponseHandler {
  static void handle(Response response) {
    final status = response.statusCode;

    switch (status) {
      case DioHttpStatus.unauthorized:
        break;
      case DioHttpStatus.notFound:
        break;
      case DioHttpStatus.internalServerError:
        break;

      default:
    }
  }

  static void handleError(DioException error) {
    final status = error.response?.statusCode;

    if (status == 401) {
    } else if (status == 404) {
    } else if (status != null && status >= 500) {}
  }
}
