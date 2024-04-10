import 'dart:convert';
// import 'dart:io';
import 'package:fontend/network/user_requests/user_network_request.dart';
import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

class AdminNetwokRequests {
  static Future<http.Response> loginAdmin(
      String adminID, String password) async {
    final http.Response response;
    response = await http.post(
      Uri.parse('http://$localHost:8000/api/v1/admin/login'),
      body: jsonEncode({'adminID': adminID, 'password': password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getDepartments() async {
    final http.Response response;
    response = await http.get(
      Uri.parse('http://$localHost:8000/api/v1/admin/get-department'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.StreamedResponse> addDoctor(
    String filepath,
    String doctorName,
    String email,
    String phone,
    String shortDescription,
    String longDescription,
    String consultationCharge,
    String departmentID,
  ) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('http://$localHost:8000/api/v1/admin/add-doctor'));
    request.fields['name'] = doctorName;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['shortDescription'] = shortDescription;
    request.fields['LongDescription'] = longDescription;
    request.fields['consultationCharge'] = consultationCharge;
    request.fields['department'] = departmentID;
    request.files.add(
      await http.MultipartFile.fromPath(
        'profile',
        filepath,
      ),
    );
    var response = await request.send();
    return response;
  }
}
