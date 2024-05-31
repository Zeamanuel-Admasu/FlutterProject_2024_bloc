import 'package:flutter/material.dart';
import '../screens/signup_page.dart';
import '../screens/login_page.dart';
import '../screens/forgot_password.dart';
import '../screens/reset_password.dart';

void main() {
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/reset_password': (context) => const ResetPasswordPage(),
      },
    );
  }
}
