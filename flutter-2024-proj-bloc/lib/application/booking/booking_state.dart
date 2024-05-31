import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/Presentation/others/bookingsClass.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<ReservedTable> bookings;
  final String type;

  const BookingLoaded(this.bookings, this.type);

  @override
  List<Object> get props => [bookings, type];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object> get props => [message];
}
