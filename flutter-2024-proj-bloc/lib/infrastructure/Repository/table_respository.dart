// lib/application/services/auth_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/Data%20Provider/table_respository.dart';
import 'package:http/http.dart' as http;

class TableRepository {
  final http.Client client;
  final BuildContext context; // Add context to access Bloc

  TableRepository(this.client, this.context);

  Future<Map<String, String>> table(String typeH, String floor, String tableNUM,
      String seatsH, String method) async {
    return await TableService(client, context)
        .table(typeH, floor, tableNUM, seatsH, method);
  }
}
