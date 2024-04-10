import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/admin/add_doctor/bloc/add_doctor_bloc.dart';
import 'package:fontend/functions/null_checker.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/text_form_field.dart';
import 'package:fontend/widgets/user_image_picker_widget.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final AddDoctorBloc addDoctorBloc = AddDoctorBloc();
  @override
  void initState() {
    addDoctorBloc.add(AddDoctorInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File? selectedImage;
    final nameTextController = TextEditingController();
    final shortDescriptionTextController = TextEditingController();
    final emailTextController = TextEditingController();
    final phoneTextController = TextEditingController();
    var selectedDepartment = "";
    final longDescriptionTextController = TextEditingController();
    final consultationCharge = TextEditingController();
    return BlocConsumer<AddDoctorBloc, AddDoctorState>(
      bloc: addDoctorBloc,
      listenWhen: (previous, current) => current is AddDoctorActionState,
      buildWhen: (previous, current) => current is! AddDoctorActionState,
      listener: (context, state) {
        if (state is AddingDoctorSuccessActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Doctor Added Successfully!'),
              duration: Duration(seconds: 1),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
          });
        }
        if (state is AddingDoctorErrorActionState) {
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
        if (state is DataLoadedSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add Doctor"),
              iconTheme: appBarIcontheme,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    children: [
                      UserImagePicker(
                        onPickImage: (pickedImage) =>
                            selectedImage = pickedImage,
                      ),
                      FormBox(
                        textController: nameTextController,
                        hintText: "Doctor Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                        textController: emailTextController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                        textController: phoneTextController,
                        hintText: "Phone",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                        textController: shortDescriptionTextController,
                        hintText: "Short Description",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                        textController: consultationCharge,
                        hintText: "Consultation Charge",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Select Department",
                            filled: true,
                            fillColor: textFormFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: appBarColor,
                              ),
                            ),
                          ),
                          items: [
                            for (final dept in state.deptName)
                              DropdownMenuItem(
                                value: dept,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: textFormFieldColor,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(dept.deptName),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            selectedDepartment = value!.deptID;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 4,
                        cursorColor: appBarColor,
                        controller: longDescriptionTextController,
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
                            hintText: "Long Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addDoctorBloc.add(AddDoctorButtonClickedEvent(
                              doctorName: nameTextController.text,
                              email: emailTextController.text,
                              phone: phoneTextController.text,
                              shortDescription:
                                  shortDescriptionTextController.text,
                              longDescription:
                                  longDescriptionTextController.text,
                              consultaioncharge: consultationCharge.text,
                              profilePhoto: selectedImage,
                              departmentID: selectedDepartment));
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            iconButtonColor,
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Add Doctor",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is DataLoadingErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: iconButtonColor,
            )),
          );
        }
      },
    );
  }
}
