import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/admin/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/text_form_field.dart';
import 'package:fontend/widgets/user_image_picker_widget.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final AddMedicineBloc addMedicineBloc = AddMedicineBloc();
  @override
  void initState() {
    addMedicineBloc.add(AddMedicineInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File? selectedImage;
    String selectedCategory = "";
    String prescriptionRequired = 'false';
    final priceTextController = TextEditingController();
    final mfgTextController = TextEditingController();
    final expTextController = TextEditingController();
    final medNameTextController = TextEditingController();
    return BlocConsumer<AddMedicineBloc, AddMedicineState>(
      bloc: addMedicineBloc,
      listenWhen: (previous, current) => current is AddMedicineActionState,
      buildWhen: (previous, current) => current is! AddMedicineActionState,
      listener: (context, state) {
        if (state is AddedMedicineSuccessActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Medicine Added Successfully!'),
              duration: Duration(seconds: 1),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
          });
        }
        if (state is AddMedicineErrorActionState) {
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
              title: const Text("Add Medicine"),
              iconTheme: appBarIcontheme,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Form(
                  child: Column(
                    children: [
                      UserImagePicker(
                        onPickImage: (pickedImage) =>
                            {selectedImage = pickedImage},
                        backgroundImgPath: "assets/images/med_img.jpg",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                          textController: medNameTextController,
                          hintText: "Medicine Name"),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                          textController: mfgTextController,
                          hintText: "MFG (YYYY-MM-DD)"),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                          textController: expTextController,
                          hintText: "EXP (YYYY-MM-DD)"),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBox(
                          textController: priceTextController,
                          hintText: "Unit Price"),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Select Category",
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
                            for (final dept in state.categoryName)
                              DropdownMenuItem(
                                value: dept,
                                child: Text(dept.categoryName),
                              ),
                          ],
                          onChanged: (value) {
                            selectedCategory = value!.categoryID;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: "Prescription Required?",
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
                        items: const [
                          DropdownMenuItem(value: 'true', child: Text('Yes')),
                          DropdownMenuItem(value: 'false', child: Text('No'))
                        ],
                        onChanged: (value) {
                          prescriptionRequired = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addMedicineBloc.add(AddMedicineButtonClickedEvent(
                            medicineImg: selectedImage,
                            medicineName: medNameTextController.text,
                            mfg: mfgTextController.text,
                            exp: expTextController.text,
                            selectedCategory: selectedCategory,
                            unitPrice: priceTextController.text,
                            prescriptionRequired: prescriptionRequired,
                          ));
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
                            "Add Medicine",
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
