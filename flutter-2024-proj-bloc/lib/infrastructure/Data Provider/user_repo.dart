import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://10.5.222.128:5000/auth/';

  Future<List<String>> fetchUser(String token) async {
    try {
      final response = await http
          .get(Uri.parse('${baseUrl}user'), headers: {'token': token});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == "success") {
          return [
            responseData['name'],
            responseData['email'],
            responseData['id']
          ];
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
