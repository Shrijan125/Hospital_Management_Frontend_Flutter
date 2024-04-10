import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fontend/features/admin/add_doctor/models/department_model.dart';
import 'package:fontend/network/admin/admin_network_request.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'add_doctor_event.dart';
part 'add_doctor_state.dart';

class AddDoctorBloc extends Bloc<AddDoctorEvent, AddDoctorState> {
  AddDoctorBloc() : super(AddDoctorInitial()) {
    on<AddDoctorInitialEvent>(addDoctorInitialEvent);
    on<AddDoctorButtonClickedEvent>(addDoctorButtonClickedEvent);
  }

  FutureOr<void> addDoctorInitialEvent(
      AddDoctorInitialEvent event, Emitter<AddDoctorState> emit) async {
    var response = await AdminNetwokRequests.getDepartments();

    List<dynamic> result = jsonDecode(response.body)['data'];
    List<DeptModel> departments = [];
    for (int i = 0; i < result.length; i++) {
      var temp = {'deptName': result[i]['name'], 'deptID': result[i]['_id']};
      var res = DeptModel.fromMap(temp);
      departments.add(res);
    }
    if (response.statusCode == 200) {
      emit(DataLoadedSuccessState(deptName: departments));
    } else if (response.statusCode == 404) {
      emit(DataLoadingErrorState(
          errorMessage: "No Departments Found. First add some department"));
    } else {
      emit(DataLoadingErrorState(errorMessage: "Something went wrong"));
    }
  }

  FutureOr<void> addDoctorButtonClickedEvent(
      AddDoctorButtonClickedEvent event, Emitter<AddDoctorState> emit) async {
    if (event.profilePhoto == null) {
      emit(AddingDoctorErrorActionState(
          errorMessage: "Profile Photo is required"));
    } else {
      var response = await AdminNetwokRequests.addDoctor(
          event.profilePhoto!.path,
          event.doctorName,
          event.email,
          event.phone,
          event.shortDescription,
          event.longDescription,
          event.consultaioncharge,
          event.departmentID);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddingDoctorSuccessActionState());
      } else {
        if (response.statusCode == 404) {
          emit(AddingDoctorErrorActionState(
              errorMessage: "All fields are required"));
        } else if (response.statusCode == 400) {
          emit(AddingDoctorErrorActionState(
              errorMessage: "Error while uploading profile"));
        } else if (response.statusCode == 500) {
          emit(AddingDoctorErrorActionState(
              errorMessage:
                  "Something went wrong while registering the doctor"));
        }
      }
    }
  }
}
