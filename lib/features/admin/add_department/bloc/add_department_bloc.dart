import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fontend/network/admin/admin_network_request.dart';

part 'add_department_event.dart';
part 'add_department_state.dart';

class AddDepartmentBloc extends Bloc<AddDepartmentEvent, AddDepartmentState> {
  AddDepartmentBloc() : super(AddDepartmentInitial()) {
    on<AddDepartmentButtonClickedEvent>(addDepartmentButtonClickedEvent);
  }

  FutureOr<void> addDepartmentButtonClickedEvent(
      AddDepartmentButtonClickedEvent event,
      Emitter<AddDepartmentState> emit) async {
    emit(AddDepartmentLoadingState());
    var response = await AdminNetwokRequests.addDepartment(event.deptName);
    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(AddDepartmentSuccessState());
    } else if (response.statusCode == 400) {
      emit(AddDepartmentErrorState("Department name is required"));
    } else if (response.statusCode == 500) {
      emit(AddDepartmentErrorState(
          "Something went wrong while creating the department"));
    } else {
      emit(AddDepartmentErrorState(
          "Something went wrong while creating the department"));
    }
  }
}
