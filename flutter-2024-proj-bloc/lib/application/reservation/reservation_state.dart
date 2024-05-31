// lib/application/bloc/reserve_state.dart

import 'package:equatable/equatable.dart';

abstract class ReserveState extends Equatable {
  const ReserveState();

  @override
  List<Object> get props => [];
}

class ReserveInitial extends ReserveState {}

class ReserveLoading extends ReserveState {}

class ReserveSuccess extends ReserveState {
  final Map<String, String> response;

  const ReserveSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class ReserveFailure extends ReserveState {
  final String error;

  const ReserveFailure(this.error);

  @override
  List<Object> get props => [error];
}
