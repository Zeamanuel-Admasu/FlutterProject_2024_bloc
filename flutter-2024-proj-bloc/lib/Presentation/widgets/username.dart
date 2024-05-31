import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
  final TextEditingController controller;

  UsernameTextField({Key? key, required this.controller}) : super(key: key);

  final usernameKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key("usernameSignup"),
      controller: controller, // Use the controller here
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        hintText: "Username",
        hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: const Color.fromARGB(255, 170, 95, 184).withOpacity(0.1),
        filled: true,
        prefixIcon: const Icon(
          Icons.person,
          color: Color.fromARGB(133, 218, 213, 213),
        ),
      ),
    );
  }
}
