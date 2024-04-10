import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/admin/add_med_category/bloc/add_medicine_category_bloc.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/text_form_field.dart';

class MedCategory extends StatelessWidget {
  const MedCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMedicineCategoryBloc addMedicineCategoryBloc =
        AddMedicineCategoryBloc();
    final medCategoryTextcontroller = TextEditingController();
    return BlocConsumer<AddMedicineCategoryBloc, AddMedicineCategoryState>(
      bloc: addMedicineCategoryBloc,
      listenWhen: (previous, current) =>
          current is AddMedicinCategoryActionState,
      buildWhen: (previous, current) =>
          current is! AddMedicinCategoryActionState,
      listener: (context, state) {
        if (state is AddMedicineCategorySuccessActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category Added Successfully!'),
              duration: Duration(seconds: 1),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
          });
        }
        if (state is AddMedicineCategoryErrorActionState) {
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
            title: const Text('Add MedCategory'),
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
                          textController: medCategoryTextcontroller,
                          hintText: "Medicine Category"),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addMedicineCategoryBloc.add(
                              AddMedicineButtonClickedEvent(
                                  categoryName:
                                      medCategoryTextcontroller.text));
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            iconButtonColor,
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: state is AddMedicineCategoryLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Add Category",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
