// test/auth_service_test.dart
import 'dart:convert';
import 'package:flutter_application_1/infrastructure/Data%20Provider/auth_repository.dart';
import 'package:flutter_application_1/infrastructure/Repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Mock class for http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      authService = AuthService(mockClient);
    });

    test('login returns token when successful', () async {
      final mockResponse = http.Response('{"token": "mock_token"}', 200);
      when(mockClient.post(
        Uri.parse("http://192.168.1.110:5000/auth/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => mockResponse);

      final result =
          await authService.login('test@example.com', 'password', 'user');
      expect(result, {'token': 'mock_token'});
    });

    test('login throws exception when unsuccessful', () async {
      final mockResponse = http.Response('{"error": "login failed"}', 400);
      when(mockClient.post(
        Uri.parse("http://192.168.1.110:5000/auth/login"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => mockResponse);

      expect(() async {
        await authService.login('test@example.com', 'password', 'user');
      }, throwsException);
    });
  });
}
