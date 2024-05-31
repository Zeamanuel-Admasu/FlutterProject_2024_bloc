// lib/bloc/booking_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/infrastructure/Repository/booking_repository.dart';

import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;
  final TokenBloc tokenBloc;

  BookingBloc({required this.bookingRepository, required this.tokenBloc})
      : super(BookingInitial()) {
    on<LoadBookings>(_onLoadBookings);
  }

  Future<void> _onLoadBookings(
      LoadBookings event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final tokenState = tokenBloc.state;
      if (tokenState is TokenUpdated) {
        final bookings =
            await bookingRepository.fetchBookings(event.type, tokenState.token);
        emit(BookingLoaded(bookings, event.type));
      } else {
        emit(BookingError('Token not available'));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
