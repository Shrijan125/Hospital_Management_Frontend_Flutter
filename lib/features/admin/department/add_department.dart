import 'package:flutter/material.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/text_form_field.dart';

class AddDepartment extends StatelessWidget {
  const AddDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    final deptTextcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Department"),
        iconTheme: appBarIcontheme,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              child: FormBox(
                  textController: deptTextcontroller,
                  hintText: "Department Name")),
        ),
      ),
    );
  }
}
