import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ChangeUsernameEvent extends Equatable {
  const ChangeUsernameEvent();

  @override
  List<Object> get props => [];
}

class ChangeUsernameRequested extends ChangeUsernameEvent {
  final String username;
  final BuildContext context;

  const ChangeUsernameRequested(this.username, this.context);

  @override
  List<Object> get props => [username, context];
}
