import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/auth_repository.dart';
import 'package:flutter_application_1/infrastructure/Repository/auth_repository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthService authService;

  SignupBloc(this.authService) : super(SignupInitial()) {
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

      final responseBody = await authService.signup(
        event.username,
        event.email,
        event.password,
      );

      print(responseBody);
      emit(SignupSuccess(message: responseBody['message']));
    } catch (error) {
      emit(SignupFailure(error: error.toString()));
    }
  }
}
