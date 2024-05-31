// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class TableService {
  final http.Client client;
  final BuildContext context; // Add context to access Bloc

  TableService(this.client, this.context);

  Future<Map<String, String>> table(String typeH, String floor, String tableNUM,
      String seatsH, String method) async {
    try {
      dynamic response;
      const urll = 'http://192.168.1.110:5000/';
      var curr_url = 'tables';

      // Retrieve the token from TokenBloc
      final tokenState = BlocProvider.of<TokenBloc>(context).state;
      String token = '';
      if (tokenState is TokenUpdated) {
        token = tokenState.token;
      } else {
        return {"error": "Token not available"};
      }

      if (method == "create") {
        response = await client.post(
          Uri.parse('${urll}${curr_url}'),
          headers: {"token": token},
          body: {
            'seats': seatsH,
            'type': typeH,
            'floor': floor,
            'tableNUM': tableNUM,
          },
        );
      } else if (method == "read") {
        response = await client.get(
          Uri.parse('${urll}${curr_url}/${tableNUM}'),
          headers: {"token": token},
        );
      } else if (method == "update") {
        response = await client.patch(
          Uri.parse('${urll}${curr_url}/${tableNUM}'),
          headers: {"token": token},
          body: {
            'updseats': seatsH,
            'updtype': typeH,
            'updfloor': floor,
            'tableNum': tableNUM,
          },
        );
      } else if (method == "delete") {
        response = await client.delete(
          Uri.parse('${urll}${curr_url}/${tableNUM}'),
          headers: {"token": token},
        );
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        if (responseData["status"] == "success") {
          if (method != "read") {
            return {'success': "successful"};
          } else {
            return {
              "tableNumber": '${responseData['tableNumber']}',
              "floor": '${responseData['floor']}',
              "Type": '${responseData['type']}',
              "seats": '${responseData['seats']}',
            };
          }
        } else {
          final errorMessage = responseData['message'];
          return {'error': errorMessage};
        }
      } else {
        final errorMessage = json.decode(response.body)['message'] as String;
        return {'error': errorMessage};
      }
    } catch (error, stackTrace) {
      print('stackTrace: $stackTrace');
      print(error);
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
