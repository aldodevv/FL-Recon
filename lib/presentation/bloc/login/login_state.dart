import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String corpId;
  final String username;
  final String password;
  final bool isLogin;
  final String isLoginFailure;
  final bool isLoadingBiometric;

  const LoginState({
    required this.corpId,
    required this.username,
    required this.password,
    required this.isLogin,
    required this.isLoginFailure,
    required this.isLoadingBiometric,
  });

  /// Initial State
  factory LoginState.initial() => const LoginState(
        corpId: '',
        username: '',
        password: '',
        isLogin: false,
        isLoginFailure: '',
        isLoadingBiometric: false,
      );

  /// CopyWith function
  LoginState copyWith({
    String? corpId,
    String? username,
    String? password,
    bool? isLogin,
    String? isLoginFailure,
    bool? isLoadingBiometric,
  }) {
    return LoginState(
      corpId: corpId ?? this.corpId,
      username: username ?? this.username,
      password: password ?? this.password,
      isLogin: isLogin ?? this.isLogin,
      isLoginFailure: isLoginFailure ?? this.isLoginFailure,
      isLoadingBiometric: isLoadingBiometric ?? this.isLoadingBiometric,
    );
  }

  @override
  List<Object> get props => [
        corpId,
        username,
        password,
        isLogin,
        isLoginFailure,
        isLoadingBiometric,
      ];
}
