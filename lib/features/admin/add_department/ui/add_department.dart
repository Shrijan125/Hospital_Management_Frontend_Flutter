import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/admin/add_department/bloc/add_department_bloc.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/elevated_button.dart';
import 'package:fontend/widgets/text_form_field.dart';

class AddDepartment extends StatelessWidget {
  const AddDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    final AddDepartmentBloc addDepartmentBloc = AddDepartmentBloc();
    final deptTextcontroller = TextEditingController();
    return BlocConsumer<AddDepartmentBloc, AddDepartmentState>(
      bloc: addDepartmentBloc,
      buildWhen: (previous, current) => current is! AddDepartmentActionState,
      listenWhen: (previous, current) => current is AddDepartmentActionState,
      listener: (context, state) {
        if (state is AddDepartmentSuccessState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Department Added Successfully!'),
              duration: Duration(seconds: 1),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
          });
        }
        if (state is AddDepartmentErrorState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Department"),
            iconTheme: appBarIcontheme,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                      child: Column(
                    children: [
                      FormBox(
                          textController: deptTextcontroller,
                          hintText: "Department Name"),
                      const SizedBox(
                        height: 20,
                      ),
                      state is AddDepartmentLoadingState
                          ? const ElevatedButtonWidget(
                              loadingState: true,
                            )
                          : ElevatedButtonWidget(
                              buttonText: "Add Department",
                              addDepartmentBloc: addDepartmentBloc,
                              deptNamecontroller: deptTextcontroller,
                            )
                    ],
                  ))),
            ),
          ),
        );
      },
    );
  }
}
