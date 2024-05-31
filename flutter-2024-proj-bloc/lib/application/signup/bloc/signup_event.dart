// application/signup/bloc/signup_event.dart
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupButtonPressed extends SignupEvent {
  final String username;
  final String email;
  final String password;

  const SignupButtonPressed({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}
