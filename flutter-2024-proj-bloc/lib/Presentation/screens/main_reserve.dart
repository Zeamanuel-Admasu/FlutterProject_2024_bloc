import 'package:flutter/material.dart';
import '../widgets/reservation_form_page.dart';

void main() {
  runApp(const MainReserve());
}

class MainReserve extends StatelessWidget {
  const MainReserve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ReservationFormPage(),
    );
  }
}
