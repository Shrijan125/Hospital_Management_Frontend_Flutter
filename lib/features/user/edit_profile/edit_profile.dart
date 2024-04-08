import 'package:flutter/material.dart';
import 'package:fontend/utils/constants.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(editProfilePageTitle),
        iconTheme: appBarIcontheme,
      ),
    );
  }
}
