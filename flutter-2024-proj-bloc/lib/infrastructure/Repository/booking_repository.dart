// lib/repository/booking_repository.dart

import 'package:flutter_application_1/Presentation/others/bookingsClass.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/booking_repository.dart';

class BookingRepository {
  Future<List<ReservedTable>> fetchBookings(String type, String token) async {
    return await BookingService().fetchBookings(type, token);
  }
}
