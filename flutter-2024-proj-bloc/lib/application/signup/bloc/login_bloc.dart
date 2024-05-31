import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc(this.authService) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<UserTypeChanged>(_onUserTypeChanged);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final responseBody = await authService.login(
        event.email,
        event.password,
        event.userType,
      );

      emit(const LoginSuccess("success"));
      emit(LoginToken(responseBody['token']));

      BlocProvider.of<TokenBloc>(event.context)
          .add(SetToken(token: responseBody['token']));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  void _onUserTypeChanged(UserTypeChanged event, Emitter<LoginState> emit) {
    emit(UserChanged(event.userType));
  }
}
