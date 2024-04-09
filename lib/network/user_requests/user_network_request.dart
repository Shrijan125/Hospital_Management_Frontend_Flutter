import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// "10.100.190.118" College
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

  static Future<http.Response> changeUserPassword(
      String oldPassword, String newPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final http.Response response;
    response = await http.put(
      Uri.parse('http://$localHost:8000/api/v1/users/change-password'),
      body:
          jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword}),
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> changeUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final http.Response response;
    response = await http.put(
      Uri.parse('http://$localHost:8000/api/v1/users/update-email'),
      body: jsonEncode({'email': email}),
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
