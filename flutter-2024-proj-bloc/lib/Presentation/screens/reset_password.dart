import '../widgets/forgot_and_reset_background.dart';
import 'package:flutter/material.dart';


class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: BackgroundImage(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue.withOpacity(0.6),
                  ),
                ),
                const Text(
                  'Create a new password. Then re-enter to confirm your new password.',
                  style: TextStyle(
                      color: Color.fromARGB(213, 255, 255, 255),
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color.fromARGB(255, 212, 197, 214)
                        .withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color.fromARGB(255, 212, 197, 214)
                        .withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {}, //here will be the user profile page
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "Continue",
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
