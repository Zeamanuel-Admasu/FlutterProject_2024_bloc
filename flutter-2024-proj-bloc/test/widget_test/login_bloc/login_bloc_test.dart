import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/login_page.dart';
import 'package:flutter_application_1/application/signup/bloc/login_bloc.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/auth_repository.dart';
import 'package:flutter_application_1/infrastructure/Repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockTokenBloc extends Mock implements TokenBloc {}

void main() {
  group('LoginScreen', () {
    testWidgets('renders login button', (WidgetTester tester) async {
      // Build the widget under test
      await tester.pumpWidget(
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(MockAuthService()),
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Verify if certain widget is rendered
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    // Add more widget tests as needed
  });
}
