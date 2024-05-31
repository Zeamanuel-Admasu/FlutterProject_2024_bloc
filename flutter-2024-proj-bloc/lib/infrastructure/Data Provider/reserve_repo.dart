// lib/application/services/reserve_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ReserveService {
  final http.Client client;
  ReserveService(this.client);

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
    try {
      const url = 'http://192.168.191.42:5000/';
      var endpoint = 'reserve';
      print(create);

      dynamic response;

      if (create) {
        response = await client.post(Uri.parse('$url$endpoint'), headers: {
          "token": token
        }, body: {
          'seats': seatsH,
          'type': typeH,
          'date': date,
          'time': time,
          'branch': branch,
          "food": foodName,
        });
      } else {
        response = await client.patch(Uri.parse('$url$endpoint'), headers: {
          "token": token
        }, body: {
          "tableNumber": tableNumber,
          'checktime': checkTime,
          'seats': seatsH,
          'type': typeH,
          'date': date,
          'time': time,
          'branch': branch,
          "food": foodName,
        });
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        if (responseData["status"] != "error") {
          return {'success': "successful"};
        } else {
          return {'error': responseData['message']};
        }
      } else {
        final errorMessage = json.decode(response.body)['message'];
        return {'error': errorMessage};
      }
    } catch (error) {
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
