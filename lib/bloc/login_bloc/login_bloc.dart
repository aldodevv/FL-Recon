import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/bloc/login_bloc/login_state.dart';
import 'package:recon/core/network/dio_client.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted, transformer: concurrent());
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final response = await DioClient().post(
        '/identity/v2.4/public/login',
        data: {
          'corporateId': event.corporateId,
          'username': event.username,
          'password': event.password,
        },
      );

      // Cek jika login berhasil berdasarkan response
      if (response.statusCode == 200) {
        emit(LoginSuccess(event.username)); // Kirim username
      } else {
        
        emit(LoginFailure('Login gagal: ${response.statusMessage}'));
      }
    } on DioException catch (e) {

      if (e.response != null) {
        emit(
          LoginFailure(
            'Login gagal: ${e.response?.data['message'] ?? 'Unknown error'}',
          ),
        );
      } else {
        emit(LoginFailure('Login gagal: ${e.message}'));
      }
    } catch (e) {
      emit(LoginFailure('Terjadi kesalahan: $e'));
    }
  }
}
