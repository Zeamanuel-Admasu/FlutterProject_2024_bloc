// lib/repository/booking_repository.dart

import 'dart:convert';
import 'package:flutter_application_1/Presentation/others/bookingsClass.dart';
import 'package:http/http.dart' as http;

class BookingService {
  Future<List<ReservedTable>> fetchBookings(String type, String token) async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.110:5000/reserve/userreservations"),
        headers: {"token": token},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData
            .map((item) => ReservedTable(
                item['Number_of_people'] as num,
                item['date'],
                item['time'],
                item['Type'],
                item['food'],
                item['branch'],
                item['tableNumber'] as int))
            .toList();
      } else {
        throw Exception('Failed to load data from backend');
      }
    } catch (e, s) {
      print("Error fetching data: $s");
      throw Exception('Failed to load data');
    }
  }
}
