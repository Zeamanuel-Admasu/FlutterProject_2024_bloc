import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(ReservationInitial());

  @override
  Stream<ReservationState> mapEventToState(ReservationEvent event) async* {
    if (event is MakeReservation) {
      yield* _mapMakeReservationToState(event);
    }
  }

  Stream<ReservationState> _mapMakeReservationToState(
      MakeReservation event) async* {
    yield ReservationLoading();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.188.161:5000/reserve'),
        headers: {'token': '${event.token}'},
        body: {
          'numberOfPeople': event.numberOfPeople.toString(),
          'date': event.date,
          'time': event.time,
          'type': event.type,
          'branch': event.branch,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        yield ReservationSuccess(responseBody['message']);
      } else {
        final responseBody = jsonDecode(response.body);
        yield ReservationFailure(responseBody['error']);
      }
    } catch (error) {
      yield ReservationFailure('Failed to make reservation: $error');
    }
  }
}
