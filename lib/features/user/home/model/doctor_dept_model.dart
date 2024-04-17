import 'dart:convert';

class DoctDeptModel {
  final String doctorName;
  final String deptName;

  DoctDeptModel({
    required this.doctorName,
    required this.deptName,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorName': doctorName,
      'deptName': deptName,
    };
  }

  factory DoctDeptModel.fromMap(Map<String, dynamic> map) {
    return DoctDeptModel(
      doctorName: map['doctorName'] ?? '',
      deptName: map['deptName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctDeptModel.fromJson(String source) =>
      DoctDeptModel.fromMap(json.decode(source));
}
