import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  Future<void> _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    try {
      print('abebe');
      print(event.email);
      print(event.password);
      print(event.username);

      final response = await http
          .post(Uri.parse('http://192.168.188.161:5000/auth/signup'), body: {
        'username': event.username,
        'email': event.email,
        'password': event.password,
      });
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print("2000");
        emit(SignupSuccess(message: responseBody['message']));
      } else {
        print("339203");
        final responseBody = jsonDecode(response.body);
        print(responseBody);

        emit(SignupFailure(error: responseBody['error']));
      }
    } catch (error) {
      emit(SignupFailure(error: error.toString()));
    }
  }
}
