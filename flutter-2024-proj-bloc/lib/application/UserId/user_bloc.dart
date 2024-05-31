import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'user_event.dart';
import 'user_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<GetUser>(_onGetUser);
  }

  Future<void> _onGetUser(
    GetUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final userId = await _fetchUserId(event.token);
      emit(AuthLoaded(userId));
    } catch (error) {
      emit(AuthError('Failed to load user ID'));
    }
  }

  Future<String> _fetchUserId(String token) async {
    print("abebe");
    final response = await http.get(
      Uri.parse('http://192.168.188.161:5000/auth/user'),
      headers: {'token': '$token'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final userId = responseBody[
          'id']; // Replace 'id' with the key for user ID in the response body
      return userId;
    } else {
      throw Exception('Failed to fetch user ID');
    }
  }
}
