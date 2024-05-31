import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/application/type/type_bloc.dart';
import 'package:flutter_application_1/application/type/type_event.dart';
import 'package:flutter_application_1/application/type/type_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TypeBloc', () {
    blocTest<TypeBloc, TypeState>(
      'emits [InitialTypeState] when UpdateTypeEvent is added',
      build: () => TypeBloc(),
      act: (bloc) => bloc.add(UpdateTypeEvent('newType')),
      expect: () => [isA<InitialTypeState>()],
    );
  });
}
