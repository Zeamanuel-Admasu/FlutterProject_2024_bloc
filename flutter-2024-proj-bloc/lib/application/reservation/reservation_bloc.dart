import 'package:flutter_application_1/application/reservation/reservation_event.dart';
import 'package:flutter_application_1/application/reservation/reservation_state.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/reserve_repo.dart';
import 'package:flutter_application_1/infrastructure/Repository/reserve_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final ReserveService reserveService;

  ReserveBloc(this.reserveService) : super(ReserveInitial()) {
    on<CreateReservation>(_onCreateReservation);
    on<UpdateReservation>(_onUpdateReservation);
  }

  Future<void> _onCreateReservation(
      CreateReservation event, Emitter<ReserveState> emit) async {
    emit(ReserveLoading());
    try {
      final response = await reserveService.reserve(
        event.token,
        event.seatsH,
        event.date,
        event.time,
        event.typeH,
        event.branch,
        event.foodName,
        true,
        event.tableNumber,
        event.checkTime,
      );
      if (response.containsKey('success')) {
        emit(ReserveSuccess(response));
      } else {
        emit(ReserveFailure(response['error']!));
      }
    } catch (error) {
      emit(ReserveFailure(error.toString()));
    }
  }

  Future<void> _onUpdateReservation(
      UpdateReservation event, Emitter<ReserveState> emit) async {
    emit(ReserveLoading());
    try {
      final response = await reserveService.reserve(
        event.token,
        event.seatsH,
        event.date,
        event.time,
        event.typeH,
        event.branch,
        event.foodName,
        false,
        event.tableNumber,
        event.checkTime,
      );
      if (response.containsKey('success')) {
        emit(ReserveSuccess(response));
      } else {
        emit(ReserveFailure(response['error']!));
      }
    } catch (error) {
      emit(ReserveFailure(error.toString()));
    }
  }
}
