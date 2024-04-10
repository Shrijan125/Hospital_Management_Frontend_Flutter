import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_home_event.dart';
part 'admin_home_state.dart';

class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  AdminHomeBloc() : super(AdminHomeInitial()) {
    on<AdminLogoutButtonCLickedEvent>(adminLogoutButtonCLickedEvent);
    on<AddDoctorButtonClickedEvent>(addDoctorButtonClickedEvent);
    on<AddDepartmentButtonClickedEvent>(addDepartmentButtonClickedEvent);
    on<AddMedCategoryButtonClickedEvent>(addMedCategoryButtonClickedEvent);
    on<AddMedicineButtonClickedEvent>(addMedicineButtonClickedEvent);
  }

  FutureOr<void> adminLogoutButtonCLickedEvent(
      AdminLogoutButtonCLickedEvent event, Emitter<AdminHomeState> emit) {
    emit(AdminLogoutActionState());
  }

  FutureOr<void> addDoctorButtonClickedEvent(
      AddDoctorButtonClickedEvent event, Emitter<AdminHomeState> emit) {
    emit(AddDoctorActionState());
  }

  FutureOr<void> addDepartmentButtonClickedEvent(
      AddDepartmentButtonClickedEvent event, Emitter<AdminHomeState> emit) {
    emit(AddDepartmentActionState());
  }

  FutureOr<void> addMedCategoryButtonClickedEvent(
      AddMedCategoryButtonClickedEvent event, Emitter<AdminHomeState> emit) {
    emit(AddMedCategoryActionState());
  }

  FutureOr<void> addMedicineButtonClickedEvent(
      AddMedicineButtonClickedEvent event, Emitter<AdminHomeState> emit) {
    emit(AddMedicineActionState());
  }
}
