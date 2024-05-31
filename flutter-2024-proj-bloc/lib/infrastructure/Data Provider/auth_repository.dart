import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client client;
  AuthService(this.client);
  static const String baseUrl = 'http://10.5.222.128:5000/auth/';

  Future<Map<String, dynamic>> login(
      String email, String password, String userType) async {
    final url = userType == "Admin" ? '${baseUrl}admin' : '${baseUrl}login';

    final response = await client.post(
      Uri.parse(url),
      headers: {
        'token': 'your_token_here'
      }, // Replace with actual token if needed
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['error']);
    }
  }

  Future<Map<String, dynamic>> signup(
      String username, String email, String password) async {
    final url = '${baseUrl}signup';

    final response = await client.post(
      Uri.parse(url),
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['error']);
    }
  }
}
