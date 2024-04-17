import 'package:flutter/material.dart';

class DoctorGridItem extends StatelessWidget {
  const DoctorGridItem(
      {super.key,
      required this.doctorName,
      required this.deptName,
      required this.profilePhoto,
      required this.shortDescription});
  final String doctorName;
  final String deptName;
  final String shortDescription;
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
              shortDescription,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Text(
              deptName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(),
      ]),
    );
  }
}
