import 'dart:convert';

class DoctorModel {
  final String doctorName;
  final String doctorID;
  DoctorModel({required this.doctorName, required this.doctorID});

  Map<String, dynamic> toMap() {
    return {
      'doctorName': doctorName,
      'doctorID': doctorID,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      doctorName: map['doctorName'] ?? '',
      doctorID: map['doctorID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source));
}
