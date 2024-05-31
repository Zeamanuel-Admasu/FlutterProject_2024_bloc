// // login_bloc_test.dart

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:flutter-2024-proj/login_bloc.dart';
// import 'package:flutter-2024-proj/login_event.dart';
// import 'package:flutter-2024-proj/login_state.dart';

// // Create a mock class for http.Client
// class MockClient extends Mock implements http.Client {}

// void main() {
//   group('LoginBloc', () {
//     late LoginBloc loginBloc;
//     late MockClient mockClient;

//     setUp(() {
//       mockClient = MockClient();
//       loginBloc = LoginBloc(client: mockClient);
//     });

//     test('Initial state is LoginInitial', () {
//       expect(loginBloc.state, isA<LoginInitial>());
//     });

//     test('Emits LoginLoading and LoginSuccess when login is successful',
//         () async {
//       final responseBody = '{"message": "Login successful", "token": "abc123"}';
//       when(mockClient.post(any,
//               headers: anyNamed('headers'), body: anyNamed('body')))
//           .thenAnswer((_) async => http.Response(responseBody, 200));

//       final expectedStates = [
//         LoginLoading(),
//         LoginSuccess('Login successful'),
//         LoginToken('abc123'),
//       ];

//       expectLater(loginBloc.stream, emitsInOrder(expectedStates));

//       loginBloc.add(LoginButtonPressed(
//           email: 'test@example.com', password: 'password', userType: 'User'));
//     });

//     test('Emits LoginLoading and LoginFailure when login fails', () async {
//       final responseBody = '{"error": "Invalid credentials"}';
//       when(mockClient.post(any,
//               headers: anyNamed('headers'), body: anyNamed('body')))
//           .thenAnswer((_) async => http.Response(responseBody, 401));

//       final expectedStates = [
//         LoginLoading(),
//         LoginFailure('Invalid credentials'),
//       ];

//       expectLater(loginBloc.stream, emitsInOrder(expectedStates));

//       loginBloc.add(LoginButtonPressed(
//           email: 'test@example.com', password: 'password', userType: 'User'));
//     });

//     tearDown(() {
//       loginBloc.close();
//     });
//   });
// }
