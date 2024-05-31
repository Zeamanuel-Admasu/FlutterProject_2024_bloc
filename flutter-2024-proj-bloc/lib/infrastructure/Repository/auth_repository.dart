import 'package:flutter_application_1/infrastructure/Data%20Provider/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthRepository {
  final http.Client client;
  AuthRepository(this.client);

  Future<Map<String, dynamic>> login(
      String email, String password, String userType) async {
    final res = await AuthService(Client()).login(email, password, userType);
    return res;
  }

  Future<Map<String, dynamic>> signup(
      String username, String email, String password) async {
    return await AuthService(Client()).signup(username, email, password);
  }
}
