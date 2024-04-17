import 'package:flutter/material.dart';

class AppointmentListTile extends StatelessWidget {
  const AppointmentListTile({
    super.key,
    required this.doctorName,
    required this.profilePhoto,
    required this.time,
  });
  final String doctorName;
  final String time;
  final String profilePhoto;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image(
              image: NetworkImage(profilePhoto),
            ),
            title: Text(
              doctorName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              time,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: const Text(
              "Payment Pending",
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
          ),
        ),
        const Divider(),
      ]),
    );
  }
}
