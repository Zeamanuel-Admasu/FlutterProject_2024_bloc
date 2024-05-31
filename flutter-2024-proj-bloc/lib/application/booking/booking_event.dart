// lib/bloc/booking_event.dart

import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class LoadBookings extends BookingEvent {
  final String type;

  const LoadBookings(this.type);

  @override
  List<Object> get props => [type];
}
