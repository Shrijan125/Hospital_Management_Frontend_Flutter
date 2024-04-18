import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

// "10.100.190.118" -> College   "192.168.9.177" -> Hostel
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

  static Future<http.Response> getDepartmentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final http.Response response;
    response = await http.get(
      Uri.parse('http://$localHost:8000/api/v1/users/getDepartment'),
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getDoctors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final Uri uri = Uri.parse('http://$localHost:8000/api/v1/users/getDoctors');
    final http.Response response;
    response = await http.get(
      uri,
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getTimeSlots(String doctorId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final Uri uri = Uri.parse('http://$localHost:8000/api/v1/users/getSlots')
        .replace(queryParameters: {'doctor_id': doctorId});
    final http.Response response;
    response = await http.get(
      uri,
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> bookAppointment(
      String doctorId, String deptId, String index, String bookedTime) async {
    final http.Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final decodedToken = JwtDecoder.decode(accessToken!);
    response = await http.post(
      Uri.parse('http://$localHost:8000/api/v1/users/book-appointment'),
      body: jsonEncode({
        'doctor_id': doctorId,
        'dept_id': deptId,
        'index': index,
        'booked_time': bookedTime,
        'user_id': decodedToken['_id']
      }),
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getAppoinments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final decodedToken = JwtDecoder.decode(accessToken!);
    final userID = decodedToken['_id'];
    final Uri uri =
        Uri.parse('http://$localHost:8000/api/v1/users/get-appointments')
            .replace(queryParameters: {'user_id': userID});
    final http.Response response;
    response = await http.get(
      uri,
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getDoctorAndDeptById(
      String doctorID, String deptID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final Uri uri =
        Uri.parse('http://$localHost:8000/api/v1/users/get-appointments')
            .replace(
                queryParameters: {'doctor_id': doctorID, 'deptID': deptID});
    final http.Response response;
    response = await http.get(
      uri,
      headers: <String, String>{
        'Authorisation': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
