import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/cancel_repository.dart';
import 'package:http/http.dart' as http;

class CancelRepository {
  final http.Client client;

  CancelRepository(this.client);

  Future<Map<String, String>> cancel(
      String time, int tableNumber, BuildContext context) async {
    try {
      return await CancelService(client).cancel(time, tableNumber, context);
    } catch (error, stackTrace) {
      print("stackTrace: $stackTrace");
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
