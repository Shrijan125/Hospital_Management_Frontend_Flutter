import 'package:flutter/material.dart';
import 'package:fontend/functions/null_checker.dart';
import 'package:fontend/utils/constants.dart';

class FormBox extends StatelessWidget {
  const FormBox(
      {super.key, required this.textController, required this.hintText});
  final TextEditingController textController;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: appBarColor,
      controller: textController,
      validator: (value) {
        if (nullEmptyValidator(value)) {
          return "Username can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
          fillColor: textFormFieldColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 2,
              color: appBarColor,
            ),
          ),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
