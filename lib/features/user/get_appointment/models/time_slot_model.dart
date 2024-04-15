import 'dart:convert';

class ModelTime {
  final DateTime startTime;
  final DateTime endTime;
  final bool booked;

  ModelTime(
      {required this.startTime, required this.endTime, required this.booked});

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'booked': booked,
    };
  }

  factory ModelTime.fromMap(Map<String, dynamic> map) {
    return ModelTime(
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      booked: map['booked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelTime.fromJson(String source) =>
      ModelTime.fromMap(json.decode(source));
}
