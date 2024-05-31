import '../widgets/email.dart';
import '../widgets/forgot_and_reset_background.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(185, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: BackgroundImage(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please provide your email address. We will send you a secure link to reset your password.',
                  style: TextStyle(
                      color: Color.fromARGB(213, 255, 255, 255),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                ),
                const SizedBox(
                  height: 25,
                ),
                emailTextField(controller: _emailController),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset_password');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "Send",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(
                  height: 110,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
