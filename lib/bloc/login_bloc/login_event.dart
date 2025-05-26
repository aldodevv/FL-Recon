part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String corporateId;
  final String username;
  final String password;

  LoginSubmitted(
    {
      required this.corporateId,
      required this.username,
      required this.password,
    }
  );

  @override
  List<Object> get props => [corporateId, username, password];
}

class LoginFormSubmitted extends LoginEvent {}
class LoginFormSetLoadingBiometric extends LoginEvent {
  final bool loading;

  LoginFormSetLoadingBiometric(this.loading);

  @override
  List<Object> get props => [loading];
}