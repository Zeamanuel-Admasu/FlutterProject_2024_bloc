import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/application/signup/bloc/signup_bloc.dart';
import 'package:flutter_application_1/application/signup/bloc/signup_event.dart';
import 'package:flutter_application_1/application/signup/bloc/signup_state.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'signup_bloc_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;
  late SignupBloc signupBloc;

  setUp(() {
    mockAuthService = MockAuthService();
    signupBloc = SignupBloc(mockAuthService);
  });

  tearDown(() {
    signupBloc.close();
  });

  group('SignupBloc', () {
    const username = 'testuser';
    const email = 'test@example.com';
    const password = 'password';
    const message = 'Signup successful';

    blocTest<SignupBloc, SignupState>(
      'emits [SignupLoading, SignupSuccess] when signup is successful',
      build: () {
        when(mockAuthService.signup(any, any, any))
            .thenAnswer((_) async => {'message': message});
        return signupBloc;
      },
      act: (bloc) => bloc.add(SignupButtonPressed(
          username: username, email: email, password: password)),
      expect: () => [
        SignupLoading(),
        const SignupSuccess(message: message),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignupLoading, SignupFailure] when signup fails',
      build: () {
        when(mockAuthService.signup(any, any, any))
            .thenThrow(Exception('Signup failed'));
        return signupBloc;
      },
      act: (bloc) => bloc.add(SignupButtonPressed(
          username: username, email: email, password: password)),
      expect: () => [
        SignupLoading(),
        const SignupFailure(error: 'Exception: Signup failed'),
      ],
    );
  });
}
