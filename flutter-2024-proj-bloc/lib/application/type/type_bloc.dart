import 'package:flutter_bloc/flutter_bloc.dart';

import 'type_event.dart';
import 'type_state.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  TypeBloc() : super(InitialTypeState('')) {
    on<UpdateTypeEvent>((event, emit) => emit(InitialTypeState(event.type)));
  }
}
