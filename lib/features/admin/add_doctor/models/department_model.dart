import 'dart:convert';

class DeptModel {
  final String deptName;
  final String deptID;
  DeptModel({required this.deptName, required this.deptID});

  Map<String, dynamic> toMap() {
    return {
      'deptName': deptName,
      'deptID': deptID,
    };
  }

  factory DeptModel.fromMap(Map<String, dynamic> map) {
    return DeptModel(
      deptName: map['deptName'] ?? '',
      deptID: map['deptID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeptModel.fromJson(String source) =>
      DeptModel.fromMap(json.decode(source));
}
