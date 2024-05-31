import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/cancel_repository.dart';
import 'package:flutter_application_1/infrastructure/Repository/cancel_repository.dart';
import 'cancel_event.dart';
import 'cancel_state.dart';

class CancelBloc extends Bloc<CancelEvent, CancelState> {
  final CancelService cancelService;

  CancelBloc({required this.cancelService}) : super(CancelInitial()) {
    on<CancelReservation>(_onCancelReservation);
  }

  Future<void> _onCancelReservation(
      CancelReservation event, Emitter<CancelState> emit) async {
    emit(CancelLoading());
    try {
      final result = await cancelService.cancel(
          event.time, event.tableNumber, event.context);
      if (result.containsKey('error')) {
        emit(CancelFailure(result['error']!));
      } else {
        emit(CancelSuccess());
      }
    } catch (error) {
      emit(CancelFailure(error.toString()));
    }
  }
}
