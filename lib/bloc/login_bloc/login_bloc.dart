import 'package:biometric_signature/android_config.dart';
import 'package:biometric_signature/biometric_signature.dart';
import 'package:biometric_signature/ios_config.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/bloc/login_bloc/login_state.dart';
import 'package:recon/core/network/dio_client.dart';
import 'package:recon/utils/utils.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted, transformer: concurrent());
    on<LoginBiometrics>(_onBiometrics, transformer: concurrent());
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

  Future<void> _onBiometrics(
    LoginBiometrics event,
    Emitter<LoginState> emit,
  ) async {
    print("Biometric login with: ${event.username}");
    final biometricSignature = BiometricSignature();
    final resultEncryptd = Utils.encryptWithKey(
      "${event.corporateId}:${event.username}:${event.password}",
    );
    print("resultEncryptd: $resultEncryptd");

    final String? biometricsType =
        await biometricSignature.biometricAuthAvailable();
    print("biometricsType : $biometricsType");

    final bool doExist =
        await biometricSignature.biometricKeyExists(checkValidity: true) ??
        false;

    if (!doExist) {
      final String? publicKey = await biometricSignature.createKeys(
        androidConfig: AndroidConfig(useDeviceCredentials: true),
        iosConfig: IosConfig(useDeviceCredentials: true),
      );
      print("publicKey : $publicKey");
    }
    try {
      final String? signature = await biometricSignature.createSignature(
        options: {
          "payload": resultEncryptd,
          "promptMessage": "Sealmat Datang Gaes!",
        },
      );

      print("signature : $signature");
      if (signature != null) {
        await _onLoginSubmitted(
          LoginSubmitted(
            event.corporateId,
            event.username,
            Utils.encryptWithKey(event.password),
          ),
          emit
        );
      } else {
        emit(LoginFailure("Biometric signature gagal."));
      }
    } catch (e) {
      emit(LoginFailure("Biometric error: $e"));
    }
  }
}
