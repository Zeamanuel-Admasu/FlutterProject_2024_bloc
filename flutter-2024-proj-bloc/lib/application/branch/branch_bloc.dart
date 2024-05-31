import 'package:flutter_bloc/flutter_bloc.dart';

import 'branch_event.dart';
import 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(InitialBranchState('')) {
    on<UpdateBranchEvent>(
        (event, emit) => emit(InitialBranchState(event.branch)));
  }
}
