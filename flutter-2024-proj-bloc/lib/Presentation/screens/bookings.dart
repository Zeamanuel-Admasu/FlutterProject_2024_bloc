import 'package:flutter/material.dart';
import '../widgets/My_bookingsState.dart';

void main() {
  runApp(const Bookings());
}

class Bookings extends StatelessWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/',
      home: const MyBookings(),
    );
  }
}
