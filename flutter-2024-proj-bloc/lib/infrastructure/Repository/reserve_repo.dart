// lib/application/services/reserve_service.dart

import 'package:flutter_application_1/infrastructure/Data%20Provider/reserve_repo.dart';
import 'package:http/http.dart' as http;

class ReserveRepository {
  final http.Client client;
  ReserveRepository(this.client);

  Future<Map<String, String>> reserve(
      String token,
      String seatsH,
      String date,
      String time,
      String typeH,
      String branch,
      String foodName,
      bool create,
      String tableNumber,
      String checkTime) async {
    return await ReserveService(client).reserve(token, seatsH, date, time,
        typeH, branch, foodName, create, tableNumber, checkTime);
  }
}
