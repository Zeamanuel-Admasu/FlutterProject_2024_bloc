import 'package:equatable/equatable.dart';

abstract class ChangeUsernameState extends Equatable {
  const ChangeUsernameState();

  @override
  List<Object> get props => [];
}

class ChangeUsernameInitial extends ChangeUsernameState {}

class ChangeUsernameLoading extends ChangeUsernameState {}

class ChangeUsernameSuccess extends ChangeUsernameState {
  final String message;

  const ChangeUsernameSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ChangeUsernameFailure extends ChangeUsernameState {
  final String error;

  const ChangeUsernameFailure(this.error);

  @override
  List<Object> get props => [error];
}
