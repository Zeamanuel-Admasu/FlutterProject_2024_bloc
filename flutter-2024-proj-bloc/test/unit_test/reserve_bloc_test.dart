import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_application_1/application/reservation/reservation_bloc.dart';
import 'package:flutter_application_1/application/reservation/reservation_event.dart';
import 'package:flutter_application_1/application/reservation/reservation_state.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/reserve_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Generate mock classes
@GenerateMocks([ReserveService])
import 'reserve_bloc_test.mocks.dart';

void main() {
  group('ReserveBloc', () {
    late ReserveBloc reserveBloc;
    late MockReserveService mockReserveService;

    setUp(() {
      mockReserveService = MockReserveService();
      reserveBloc = ReserveBloc(mockReserveService);
    });

    tearDown(() {
      reserveBloc.close();
    });

    blocTest<ReserveBloc, ReserveState>(
      'emits [ReserveLoading, ReserveSuccess] when reservation creation is successful',
      build: () {
        when(mockReserveService.reserve(
                any, any, any, any, any, any, any, any, any, any))
            .thenAnswer((_) async => {'success': "successful"});
        return reserveBloc;
      },
      act: (bloc) => bloc.add(CreateReservation(
        token: 'token',
        seatsH: '4',
        date: '2022-10-10',
        time: '18:00',
        typeH: 'dinner',
        branch: 'main',
        foodName: 'pizza',
        tableNumber: '10',
        checkTime: '20:00',
      )),
      expect: () => [
        ReserveLoading(),
        ReserveSuccess({'success': 'successful'})
      ],
    );

    blocTest<ReserveBloc, ReserveState>(
      'emits [ReserveLoading, ReserveFailure] when reservation creation fails with error message',
      build: () {
        when(mockReserveService.reserve(
                any, any, any, any, any, any, any, any, any, any))
            .thenAnswer((_) async => {'error': "some error"});
        return reserveBloc;
      },
      act: (bloc) => bloc.add(CreateReservation(
        token: 'token',
        seatsH: '4',
        date: '2022-10-10',
        time: '18:00',
        typeH: 'dinner',
        branch: 'main',
        foodName: 'pizza',
        tableNumber: '10',
        checkTime: '20:00',
      )),
      expect: () => [ReserveLoading(), ReserveFailure('some error')],
    );

    blocTest<ReserveBloc, ReserveState>(
      'emits [ReserveLoading, ReserveFailure] when an exception is thrown during reservation creation',
      build: () {
        when(mockReserveService.reserve(
                any, any, any, any, any, any, any, any, any, any))
            .thenThrow(Exception('Unexpected error'));
        return reserveBloc;
      },
      act: (bloc) => bloc.add(CreateReservation(
        token: 'token',
        seatsH: '4',
        date: '2022-10-10',
        time: '18:00',
        typeH: 'dinner',
        branch: 'main',
        foodName: 'pizza',
        tableNumber: '10',
        checkTime: '20:00',
      )),
      expect: () =>
          [ReserveLoading(), ReserveFailure('Exception: Unexpected error')],
    );

    blocTest<ReserveBloc, ReserveState>(
      'emits [ReserveLoading, ReserveSuccess] when reservation update is successful',
      build: () {
        when(mockReserveService.reserve(
                any, any, any, any, any, any, any, any, any, any))
            .thenAnswer((_) async => {'success': "successful"});
        return reserveBloc;
      },
      act: (bloc) => bloc.add(UpdateReservation(
        token: 'token',
        seatsH: '4',
        date: '2022-10-10',
        time: '18:00',
        typeH: 'dinner',
        branch: 'main',
        foodName: 'pizza',
        tableNumber: '10',
        checkTime: '20:00',
      )),
      expect: () => [
        ReserveLoading(),
        ReserveSuccess({'success': 'successful'})
      ],
    );

    blocTest<ReserveBloc, ReserveState>(
      'emits [ReserveLoading, ReserveFailure] when reservation update fails with error message',
      build: () {
        when(mockReserveService.reserve(
                any, any, any, any, any, any, any, any, any, any))
            .thenAnswer((_) async => {'error': "some error"});
        return reserveBloc;
      },
      act: (bloc) => bloc.add(UpdateReservation(
        token: 'token',
        seatsH: '4',
        date: '2022-10-10',
        time: '18:00',
        typeH: 'dinner',
        branch: 'main',
        foodName: 'pizza',
        tableNumber: '10',
        checkTime: '20:00',
      )),
      expect: () => [ReserveLoading(), ReserveFailure('some error')],
    );

    blocTest<ReserveBloc, ReserveState>(
      'emits [ReserveLoading, ReserveFailure] when an exception is thrown during reservation update',
      build: () {
        when(mockReserveService.reserve(
                any, any, any, any, any, any, any, any, any, any))
            .thenThrow(Exception('Unexpected error'));
        return reserveBloc;
      },
      act: (bloc) => bloc.add(UpdateReservation(
        token: 'token',
        seatsH: '4',
        date: '2022-10-10',
        time: '18:00',
        typeH: 'dinner',
        branch: 'main',
        foodName: 'pizza',
        tableNumber: '10',
        checkTime: '20:00',
      )),
      expect: () =>
          [ReserveLoading(), ReserveFailure('Exception: Unexpected error')],
    );
  });
}
