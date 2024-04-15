import 'dart:convert';

import 'package:fontend/features/user/get_appointment/models/time_slot_model.dart';

class DoctorTimeModel {
  final String doctorName;
  final String doctorID;
  final String departmentID;
  final List<ModelTime> timeArray;
  final String consultationCharge;
  DoctorTimeModel(
      {required this.doctorName,
      required this.doctorID,
      required this.departmentID,
      required this.timeArray,
      required this.consultationCharge});

  Map<String, dynamic> toMap() {
    return {
      'doctorName': doctorName,
      'doctorID': doctorID,
      'departmentID': departmentID,
      'timeArray': timeArray.map((x) => x.toMap()).toList(),
    };
  }

  factory DoctorTimeModel.fromMap(Map<String, dynamic> map) {
    return DoctorTimeModel(
        doctorName: map['doctorName'] ?? '',
        doctorID: map['doctorID'] ?? '',
        departmentID: map['departmentID'] ?? '',
        timeArray: map['timeArray'] ?? [],
        consultationCharge: map['consultationCharge'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory DoctorTimeModel.fromJson(String source) =>
      DoctorTimeModel.fromMap(json.decode(source));
}
