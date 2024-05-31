import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CancelService {
  final http.Client client;

  CancelService(this.client);

  Future<Map<String, String>> cancel(
      String time, int tableNumber, BuildContext context) async {
    try {
      print("dfsssssssssssssssssssssssssssssss");
      const url = 'http://192.168.191.42:5000/';
      final endpoint = 'reserve/delete';

      final tokenState = context.read<TokenBloc>().state;
      String token = '';
      if (tokenState is TokenUpdated) {
        token = tokenState.token;
      }
      print(Uri.parse('$url$endpoint/$tableNumber&$time'));

      final response = await client.delete(
        headers: {"token": token},
        Uri.parse('$url$endpoint$tableNumber&$time'),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print("dsiiiiiiiiii");

        if (responseData["status"] == "success") {
          return {'success': "successful"};
        } else {
          final errorMessage = responseData['error'] as String;
          return {'error': errorMessage};
        }
      } else {
        print(response.statusCode);
        final errorMessage = json.decode(response.body)['message'] as String;
        return {'error': errorMessage};
      }
    } catch (error, stackTrace) {
      print("stackTrace: $stackTrace");
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
