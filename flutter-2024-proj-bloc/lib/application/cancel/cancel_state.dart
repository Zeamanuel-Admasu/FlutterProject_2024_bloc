import 'package:equatable/equatable.dart';

abstract class CancelState extends Equatable {
  @override
  List<Object> get props => [];
}

class CancelInitial extends CancelState {}

class CancelLoading extends CancelState {}

class CancelSuccess extends CancelState {}

class CancelFailure extends CancelState {
  final String error;

  CancelFailure(this.error);

  @override
  List<Object> get props => [error];
}
