import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final String token;

  const LoadUser(this.token);

  @override
  List<Object> get props => [token];
}
