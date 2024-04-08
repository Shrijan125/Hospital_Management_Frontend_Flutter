import 'dart:convert';
import 'package:http/http.dart' as http;

const localHost = "192.168.9.177";

class UserNetworkRequests {
  static Future<http.Response> signUpUser(
      String username, String email, String password) async {
    final http.Response response;

    response = await http.post(
        Uri.parse('http://$localHost:8000/api/v1/users/register'),
        body: jsonEncode(
            {'username': username, 'password': password, 'email': email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    return response;
  }

  static Future<http.Response> loginUser(
      String username, String password) async {
    final http.Response response;
    response = await http.post(
      Uri.parse('http://$localHost:8000/api/v1/users/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getUserDetails() async {
    final http.Response response;
    response = await http.get(
      Uri.parse('http://$localHost:8000/api/v1/users/getCurrentUser'),
    );
    return response;
  }
}
