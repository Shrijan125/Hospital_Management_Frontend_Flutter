import 'dart:convert';

class AppointmentModel {
  final String doctorName;
  final String profilePhoto;
  final String time;

  AppointmentModel({
    required this.doctorName,
    required this.profilePhoto,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorName': doctorName,
      'profilePhoto': profilePhoto,
      'time': time,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      doctorName: map['doctorName'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source));
}
