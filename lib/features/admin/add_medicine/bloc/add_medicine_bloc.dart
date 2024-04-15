import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fontend/features/admin/add_medicine/models/med_category.dart';
import 'package:fontend/network/admin/admin_network_request.dart';
import 'package:meta/meta.dart';

part 'add_medicine_event.dart';
part 'add_medicine_state.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {
  AddMedicineBloc() : super(AddMedicineInitial()) {
    on<AddMedicineInitialEvent>(addMedicineInitialEvent);
    on<AddMedicineButtonClickedEvent>(addMedicineButtonClickedEvent);
  }

  FutureOr<void> addMedicineInitialEvent(
      AddMedicineInitialEvent event, Emitter<AddMedicineState> emit) async {
    var response = await AdminNetwokRequests.getMedicineCategory();

    List<dynamic> result = jsonDecode(response.body)['data'];
    List<MedicineCategory> categories = [];
    for (int i = 0; i < result.length; i++) {
      var temp = {
        'categoryName': result[i]['category'],
        'categoryID': result[i]['_id']
      };
      var res = MedicineCategory.fromMap(temp);
      categories.add(res);
    }
    if (response.statusCode == 200) {
      emit(DataLoadedSuccessState(categoryName: categories));
    } else if (response.statusCode == 404) {
      emit(DataLoadingErrorState(
          errorMessage: "No Departments Found. First add some department"));
    } else {
      emit(DataLoadingErrorState(errorMessage: "Something went wrong"));
    }
  }

  FutureOr<void> addMedicineButtonClickedEvent(
      AddMedicineButtonClickedEvent event,
      Emitter<AddMedicineState> emit) async {
    if (event.medicineImg == null) {
      emit(AddMedicineErrorActionState(
          errorMessage: "Medicine Image is required"));
    } else {
      var response = await AdminNetwokRequests.addMedicine(
        event.medicineImg!.path,
        event.medicineName,
        event.mfg,
        event.exp,
        event.selectedCategory,
        event.unitPrice,
        event.prescriptionRequired,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddedMedicineSuccessActionState());
      } else {
        if (response.statusCode == 404) {
          emit(AddMedicineErrorActionState(
              errorMessage: "All fields are required"));
        } else if (response.statusCode == 400) {
          emit(AddMedicineErrorActionState(
              errorMessage: "Error while uploading profile"));
        } else if (response.statusCode == 500) {
          emit(AddMedicineErrorActionState(
              errorMessage:
                  "Something went wrong while registering the doctor"));
        }
      }
    }
  }
}
