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
}
