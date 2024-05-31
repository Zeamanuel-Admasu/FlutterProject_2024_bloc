// login_bloc.dart
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final response = await http.post(
        Uri.parse('http://192.168.188.161:5000/auth/login'),
        headers: {'token': 'your_token_here'}, // Replace with actual token
        body: {
          'password': event.password,
          'email': event.email,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        emit(LoginSuccess(responseBody['message']));
        emit(LoginToken(responseBody['token']));
      } else {
        final responseBody = jsonDecode(response.body);
        emit(LoginFailure(responseBody['error']));
      }
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
