import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recon/core/constants/app_const.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/network/dio_client.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/domain/entitites/signin.dart';
import 'package:recon/presentation/bloc/login/login_state.dart';

part 'login_event.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted, transformer: concurrent());
    on<LoginFormSetLoadingBiometric>(
      _onSetLoadingBiometric,
      transformer: sequential(),
    );
    on<LoginFormSubmitted>(_onLoginBiometrics, transformer: sequential());
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLogin: true));
    try {
      final response = await DioClient().post(
        '${AppConst.identityV2_4}/public/login',
        data: {
          'corporateId': event.corporateId,
          'username': event.username,
          'password': event.password,
        },
      );

      // Parse response ke SigninEntity
      final data = SigninEntity.fromJson(response.data);

      if (data.statusCode == 200) {
        emit(
          state.copyWith(
            username: event.username,
            isLogin: false,
            isLoginSuccess: true,
          ),
        );
        await Utils.storageSecure.write(
          key: 'token',
          value: data.response!.token,
        );
      } else {
        emit(
          state.copyWith(
            isLogin: false,
            isLoginFailure: 'Login gagal: ${data.message ?? 'Unknown error'}',
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        emit(
          state.copyWith(
            isLogin: false,
            isLoginFailure: 'Login gagal: ${e.response?.data['message']}',
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLogin: false,
            isLoginFailure: 'Login gagal: ${e.message}',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(isLogin: false, isLoginFailure: 'Terjadi kesalahan: $e'),
      );
    }
  }

  void _onLoginBiometrics(
    LoginFormSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final String? token = await Utils.storageSecure.read(key: 'token');
    if (token == null) return;

    try {
      final response = await DioApp.instance.get(
        '${AppConst.identityV1}/private/token/check',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print("wodkowkdo: ${response.data}");
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  void _onSetLoadingBiometric(
    LoginFormSetLoadingBiometric event,
    Emitter<LoginState> emit,
  ) {
    // Pastikan LoginState memiliki field `isLoadingBiometric` jika ingin memakai ini
    emit(state.copyWith(isLoadingBiometric: true));
  }
}
