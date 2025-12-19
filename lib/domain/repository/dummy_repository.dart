import 'package:dartz/dartz.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/network/failure_response.dart';
import 'package:recon/domain/model/dummy_model.dart';

class DummyRepository {
  Future<Either<AppFailure, List<ResponsePost>>> getPosts() async {
    final api = DioApp(baseUrl: BaseUrl.main);

    final failureOrResponse = await api.get<List>('/posts');

    return failureOrResponse.fold(
      (l) => Left(AppFailure(message: l.message, type: l.type, rc: l.rc)),
      (r) => Right((r).map((e) => ResponsePost.from(e)).toList()),
    );
  }
}
