import 'dart:convert';
import 'package:fontend/network/user/user_network_request.dart';
import 'package:http/http.dart' as http;

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

  static Future<http.Response> addDepartment(String departmentName) async {
    final http.Response response;
    response = await http.post(
      Uri.parse('http://$localHost:8000/api/v1/admin/add-department'),
      body: jsonEncode({'name': departmentName}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> addMedCategory(String category) async {
    final http.Response response;
    response = await http.post(
      Uri.parse('http://$localHost:8000/api/v1/admin/add-medicine-category'),
      body: jsonEncode({'category': category}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> getMedicineCategory() async {
    final http.Response response;
    response = await http.get(
      Uri.parse('http://$localHost:8000/api/v1/admin/get-medicine-category'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.StreamedResponse> addMedicine(
      String filepath,
      String medicineName,
      String mfg,
      String exp,
      String categoryID,
      String unitPrice,
      String prescritionRequired) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('http://$localHost:8000/api/v1/admin/add-medicine'));
    request.fields['name'] = medicineName;
    request.fields['category'] = categoryID;
    request.fields['mfg'] = mfg;
    request.fields['exp'] = exp;
    request.fields['price'] = unitPrice;
    request.fields['prescReq'] = prescritionRequired;
    request.files.add(
      await http.MultipartFile.fromPath(
        'medImage',
        filepath,
      ),
    );
    var response = await request.send();
    return response;
  }
}
