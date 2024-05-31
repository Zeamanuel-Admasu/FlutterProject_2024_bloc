// lib/application/bloc/reserve_event.dart

import 'package:equatable/equatable.dart';

abstract class ReserveEvent extends Equatable {
  const ReserveEvent();

  @override
  List<Object> get props => [];
}

class CreateReservation extends ReserveEvent {
  final String token;
  final String seatsH;
  final String date;
  final String time;
  final String typeH;
  final String branch;
  final String foodName;
  final String tableNumber;
  final String checkTime;

  const CreateReservation({
    required this.token,
    required this.seatsH,
    required this.date,
    required this.time,
    required this.typeH,
    required this.branch,
    required this.foodName,
    required this.tableNumber,
    required this.checkTime,
  });

  @override
  List<Object> get props => [
        token,
        seatsH,
        date,
        time,
        typeH,
        branch,
        foodName,
        tableNumber,
        checkTime
      ];
}

class UpdateReservation extends ReserveEvent {
  final String token;
  final String seatsH;
  final String date;
  final String time;
  final String typeH;
  final String branch;
  final String foodName;
  final String tableNumber;
  final String checkTime;

  const UpdateReservation({
    required this.token,
    required this.seatsH,
    required this.date,
    required this.time,
    required this.typeH,
    required this.branch,
    required this.foodName,
    required this.tableNumber,
    required this.checkTime,
  });

  @override
  List<Object> get props => [
        token,
        seatsH,
        date,
        time,
        typeH,
        branch,
        foodName,
        tableNumber,
        checkTime
      ];
}
