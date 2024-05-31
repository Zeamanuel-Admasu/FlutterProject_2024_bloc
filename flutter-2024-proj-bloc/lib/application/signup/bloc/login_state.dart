// application/signup/bloc/login_state.dart
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  const LoginSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LoginToken extends LoginState {
  final String token;

  const LoginToken(this.token);

  @override
  List<Object> get props => [token];
}

class UserChanged extends LoginState {
  final String user;

  const UserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
