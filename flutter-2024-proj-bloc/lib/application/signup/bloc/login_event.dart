// application/signup/bloc/login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserTypeChanged extends LoginEvent {
  final String userType;

  const UserTypeChanged(this.userType);

  @override
  List<Object> get props => [userType];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final String userType;

  const LoginButtonPressed({
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object> get props => [email, password, userType];
}
