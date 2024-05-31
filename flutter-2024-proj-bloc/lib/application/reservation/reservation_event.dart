import 'package:equatable/equatable.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class MakeReservation extends ReservationEvent {
  final String token; // Pass the token obtained from login
  final int numberOfPeople;
  final String date;
  final String time;
  final String type;
  final String branch;

  const MakeReservation({
    required this.token,
    required this.numberOfPeople,
    required this.date,
    required this.time,
    required this.type,
    required this.branch,
  });

  @override
  List<Object> get props => [token, numberOfPeople, date, time, type, branch];
}
