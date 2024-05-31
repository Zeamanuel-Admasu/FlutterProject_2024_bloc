import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChangeUsernameService {
  static const String baseUrl = 'http://192.168.1.110:5000/auth/';

  Future<String> changeUsername(String username, BuildContext context) async {
    try {
      final tokenState = BlocProvider.of<TokenBloc>(context).state;
      String token = '';
      if (tokenState is TokenUpdated) {
        token = tokenState.token;
      }
      final response = await http.post(
        Uri.parse('${baseUrl}changeusername'),
        headers: {"token": token},
        body: {'username': username},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        return responseData['message'];
      } else {
        final errorMessage = json.decode(response.body)['message'] as String;
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception('Error occurred: $error');
    }
  }
}
