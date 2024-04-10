import 'package:flutter/material.dart';
import 'package:fontend/features/admin/add_department/bloc/add_department_bloc.dart';
import 'package:fontend/utils/constants.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key,
      this.buttonText,
      this.loadingState,
      this.addDepartmentBloc,
      this.deptNamecontroller});
  final String? buttonText;
  final bool? loadingState;
  final AddDepartmentBloc? addDepartmentBloc;
  final TextEditingController? deptNamecontroller;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (addDepartmentBloc != null && deptNamecontroller != null) {
          addDepartmentBloc!.add(AddDepartmentButtonClickedEvent(
              deptName: deptNamecontroller!.text));
        }
      },
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          iconButtonColor,
        ),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: buttonText != null
            ? Text(
                buttonText!,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
