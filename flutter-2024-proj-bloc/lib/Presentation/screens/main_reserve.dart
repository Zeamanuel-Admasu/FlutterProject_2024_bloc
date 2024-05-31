import 'package:flutter/material.dart';
import '../widgets/reservation_form_page.dart';

class MainReserve extends StatelessWidget {
  final String data;
  final String create;
  final String tableNumber;
  final String checkTime;

  MainReserve(
      {Key? key,
      required this.checkTime,
      required this.data,
      required this.create,
      required this.tableNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReservationFormPage(
          data: data,
          create: create == "true",
          tableNumber: tableNumber,
          checkTime: checkTime),
    );
  }
}
