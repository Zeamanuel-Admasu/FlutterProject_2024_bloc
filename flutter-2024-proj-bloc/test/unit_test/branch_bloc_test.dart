import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/application/branch/branch_bloc.dart';
import 'package:flutter_application_1/application/branch/branch_event.dart';
import 'package:flutter_application_1/application/branch/branch_state.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BranchBloc', () {
    blocTest<BranchBloc, BranchState>(
      'emits [InitialTypeState] wBranch is added',
      build: () => BranchBloc(),
      act: (bloc) => bloc.add(UpdateBranchEvent('newType')),
      expect: () => [isA<InitialBranchState>()],
    );
  });
}
