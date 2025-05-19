part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String corporateId;
  final String username;
  final String password;

  LoginSubmitted(this.corporateId, this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
