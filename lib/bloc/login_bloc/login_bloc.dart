import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recon/bloc/login_bloc/login_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
   on<LoginSubmitted>((event, emit) async {
  emit(LoginLoading());

  await Future.delayed(const Duration(seconds: 1));

  if (event.username == 'admin' && event.password == '1234') {
    emit(LoginSuccess(event.username)); // ← kirim username
  } else {
    emit(LoginFailure('Username atau password salah'));
  }
}, transformer: concurrent());
  }
}
