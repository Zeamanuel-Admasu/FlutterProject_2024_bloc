import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/application/booking/booking_bloc.dart';
import 'package:flutter_application_1/application/booking/booking_event.dart';
import 'package:flutter_application_1/application/booking/booking_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/infrastructure/Repository/booking_repository.dart';

import 'package:flutter_application_1/Presentation/others/bookingsClass.dart';
import 'package:matcher/matcher.dart' as m;

@GenerateMocks([BookingRepository, TokenBloc])
import 'booking_bloc_test.mocks.dart';

void main() {
  group('BookingBloc', () {
    late MockBookingRepository bookingRepository;
    late MockTokenBloc tokenBloc;
    late BookingBloc bookingBloc;

    setUp(() {
      bookingRepository = MockBookingRepository();
      tokenBloc = MockTokenBloc();
      bookingBloc = BookingBloc(
        bookingRepository: bookingRepository,
        tokenBloc: tokenBloc,
      );
    });

    tearDown(() {
      bookingBloc.close();
    });

    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, BookingLoaded] when LoadBookings is added and token is available',
      build: () {
        when(tokenBloc.state).thenReturn(TokenUpdated(token: 'valid_token'));
        when(bookingRepository.fetchBookings(any, any)).thenAnswer(
          (_) async => [
            ReservedTable(
                4, '2024-06-19', '19:00', 'Dinner', 'Pasta', 'Branch A', 10),
          ],
        );
        return bookingBloc;
      },
      act: (bloc) => bloc.add(LoadBookings('Dinner')),
      expect: () => [
        BookingLoading(),
        isA<BookingLoaded>()
            .having(
              (state) => state.bookings,
              'bookings',
              contains(
                ReservedTable(4, '2024-06-19', '19:00', 'Dinner', 'Pasta',
                    'Branch A', 10),
              ),
            )
            .having((state) => state.type, 'type', 'Dinner'),
      ],
      verify: (_) {
        verify(bookingRepository.fetchBookings('Dinner', 'valid_token'))
            .called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, BookingError] when LoadBookings is added and token is not available',
      build: () {
        when(tokenBloc.state).thenReturn(TokenInitial());
        return bookingBloc;
      },
      act: (bloc) => bloc.add(LoadBookings('Dinner')),
      expect: () => [
        BookingLoading(),
        isA<BookingError>()
            .having((state) => state.message, 'message', 'Token not available'),
      ],
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, BookingError] when LoadBookings is added and fetchBookings throws an exception',
      build: () {
        when(tokenBloc.state).thenReturn(TokenUpdated(token: 'valid_token'));
        when(bookingRepository.fetchBookings(any, any))
            .thenThrow(Exception('Failed to load data'));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(LoadBookings('Dinner')),
      expect: () => [
        BookingLoading(),
        isA<BookingError>().having((state) => state.message, 'message',
            'Exception: Failed to load data'),
      ],
    );
  });
}
