import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fontend/network/admin/admin_network_request.dart';
import 'package:meta/meta.dart';

part 'add_medicine_category_event.dart';
part 'add_medicine_category_state.dart';

class AddMedicineCategoryBloc
    extends Bloc<AddMedicineCategoryEvent, AddMedicineCategoryState> {
  AddMedicineCategoryBloc() : super(AddMedicineCategoryInitial()) {
    on<AddMedicineButtonClickedEvent>(addMedicineButtonClickedEvent);
  }

  FutureOr<void> addMedicineButtonClickedEvent(
      AddMedicineButtonClickedEvent event,
      Emitter<AddMedicineCategoryState> emit) async {
    emit(AddMedicineCategoryLoadingState());
    var response = await AdminNetwokRequests.addMedCategory(event.categoryName);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(AddMedicineCategorySuccessActionState());
    } else if (response.statusCode == 400) {
      emit(AddMedicineCategoryErrorActionState(
          errorMessage: "Category is required"));
      emit(AddMedicineCategoryInitial());
    } else if (response.statusCode == 500) {
      emit(AddMedicineCategoryErrorActionState(
          errorMessage: "Something went wrong while creating the category"));
      emit(AddMedicineCategoryInitial());
    } else {
      emit(AddMedicineCategoryErrorActionState(
          errorMessage: "Something went wrong while creating the category"));
      emit(AddMedicineCategoryInitial());
    }
  }
}
