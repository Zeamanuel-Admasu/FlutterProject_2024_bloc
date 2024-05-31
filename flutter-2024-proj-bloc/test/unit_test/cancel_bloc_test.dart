import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/cancel/cancel_bloc.dart';
import 'package:flutter_application_1/application/cancel/cancel_event.dart';
import 'package:flutter_application_1/application/cancel/cancel_state.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/cancel_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CancelService, TokenBloc, BuildContext])
import 'cancel_bloc_test.mocks.dart';

void main() {
  late MockCancelService mockCancelService;
  late CancelBloc cancelBloc;

  setUp(() {
    mockCancelService = MockCancelService();
    cancelBloc = CancelBloc(cancelService: mockCancelService);
  });

  tearDown(() {
    cancelBloc.close();
  });

  group('CancelBloc', () {
    final time = '12:00';
    final tableNumber = 1;
    final context = MockBuildContext();

    blocTest<CancelBloc, CancelState>(
      'emits [CancelLoading, CancelSuccess] when cancel is successful',
      build: () {
        when(mockCancelService.cancel(any, any, any))
            .thenAnswer((_) async => {'success': 'successful'});
        return cancelBloc;
      },
      act: (bloc) => bloc.add(CancelReservation(time, tableNumber, context)),
      expect: () => [CancelLoading(), CancelSuccess()],
    );

    blocTest<CancelBloc, CancelState>(
      'emits [CancelLoading, CancelFailure] when cancel fails',
      build: () {
        when(mockCancelService.cancel(any, any, any))
            .thenAnswer((_) async => {'error': 'Error occurred'});
        return cancelBloc;
      },
      act: (bloc) => bloc.add(CancelReservation(time, tableNumber, context)),
      expect: () => [CancelLoading(), CancelFailure('Error occurred')],
    );

    blocTest<CancelBloc, CancelState>(
      'emits [CancelLoading, CancelFailure] when an exception is thrown',
      build: () {
        when(mockCancelService.cancel(any, any, any))
            .thenThrow(Exception('Network error'));
        return cancelBloc;
      },
      act: (bloc) => bloc.add(CancelReservation(time, tableNumber, context)),
      expect: () =>
          [CancelLoading(), CancelFailure('Exception: Network error')],
    );
  });
}
