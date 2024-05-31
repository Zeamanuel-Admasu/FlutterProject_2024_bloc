// presentation/widgets/email.dart
import 'package:flutter/material.dart';

class emailTextField extends StatelessWidget {
  final TextEditingController controller;

  const emailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        hintText: "email",
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
