import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends AuthEvent {
  final String token;

  const GetUser(this.token);

  @override
  List<Object> get props => [token];
}
