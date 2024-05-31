import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CancelEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CancelReservation extends CancelEvent {
  final String time;
  final int tableNumber;
  final BuildContext context;

  CancelReservation(this.time, this.tableNumber, this.context);

  @override
  List<Object> get props => [time, tableNumber, context];
}
