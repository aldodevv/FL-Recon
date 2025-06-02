import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recon/core/constants/app_url.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/domain/entitites/me.dart';
import 'package:recon/presentation/bloc/me/me_event.dart';
import 'package:recon/presentation/bloc/me/me_state.dart';

@injectable
class MeBloc extends Bloc<MeEvent, MeState> {
  MeBloc() : super(MeState.initial()) {
    on<MeGet>(_onLoadMe, transformer: sequential());
  }

  void _onLoadMe(MeGet event, Emitter<MeState> emit) async {
    final String? token = await Utils.storageSecure.read(key: 'token');
    try {
      final response = await DioApp.instance.get(
        '${AppUrl.identityV1}/private/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );      
      final Map<String, dynamic> data = response.data;      
      final meResponse = MeResponseEntity.fromJson(data);      
      final user = meResponse.response;      
      emit(
        state.copyWith(
          corpId: user.corporateId,
          corporateName: user.corporateName,
          username: user.username,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
