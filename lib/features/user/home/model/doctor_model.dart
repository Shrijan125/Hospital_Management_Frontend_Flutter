import 'dart:convert';

class DoctorModel {
  final String name;
  final String profilePhoto;
  final String shortDescription;
  final String department;

  DoctorModel(
      {required this.name,
      required this.profilePhoto,
      required this.shortDescription,
      required this.department});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePhoto': profilePhoto,
      'shortDescription': shortDescription,
      'department': department,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      name: map['name'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      department: map['department'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source));
}
