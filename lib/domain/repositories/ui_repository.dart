import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/network/failure_response.dart';
import 'package:recon/domain/entitites/ui/entity_language.dart';

@LazySingleton()
class UiLanguageRepository {
  static const String _getLanguageUrl = '/ui/v1.1.0/public/userInterface/ID';

  Future<Either<ResponseFailed, Response<EntityLanguage>>> getUIData() async {
    return DioApp.instance.safeRequest(() => DioApp.instance.dio.get(_getLanguageUrl),
    );
  }

  String? getLabelById(List<EntityItemLanguage> data, String id) {
    return data.firstWhere(
      (e) => e.id == id,
      orElse: () => EntityItemLanguage(id: '', label: '', group: ''),
    ).label;
  }
}
