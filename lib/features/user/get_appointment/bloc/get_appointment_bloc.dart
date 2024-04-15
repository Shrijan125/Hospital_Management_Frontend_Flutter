import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fontend/features/admin/add_doctor/models/department_model.dart';
import 'package:fontend/features/user/get_appointment/models/doctor_time_model.dart';
import 'package:fontend/features/user/get_appointment/models/time_slot_model.dart';
import 'package:fontend/network/user/user_network_request.dart';
import 'package:meta/meta.dart';

part 'get_appointment_event.dart';
part 'get_appointment_state.dart';

class GetAppointmentBloc
    extends Bloc<GetAppointmentEvent, GetAppointmentState> {
  GetAppointmentBloc() : super(GetAppointmentInitial()) {
    on<GetAppointmentInitialEvent>(getAppointmentInitialEvent);
    on<BookAppointmentButtonClickedEvent>(bookAppointmentButtonClickedEvent);
  }

  FutureOr<void> getAppointmentInitialEvent(GetAppointmentInitialEvent event,
      Emitter<GetAppointmentState> emit) async {
    emit(GetAppointmentDataLoadingState());
    var responseDept = await UserNetworkRequests.getDepartmentUser();
    var responseDoct = await UserNetworkRequests.getDoctors();
    if ((responseDept.statusCode == 200 || responseDept.statusCode == 201) &&
        (responseDoct.statusCode == 200 || responseDoct.statusCode == 201)) {
      List<dynamic> resultDept = jsonDecode(responseDept.body)['data'];

      List<DeptModel> departments = [];
      for (int i = 0; i < resultDept.length; i++) {
        var temp = {
          'deptName': resultDept[i]['name'],
          'deptID': resultDept[i]['_id']
        };

        var res = DeptModel.fromMap(temp);
        departments.add(res);
      }
      List<dynamic> resultDoct = jsonDecode(responseDoct.body)['data'];
      List<List<ModelTime>> doctorsTime = [];
      for (int i = 0; i < resultDoct.length; i++) {
        final List<ModelTime> temp = [];
        for (int j = 0; j < resultDoct[i]['availability'].length; j++) {
          var tempIndividual = {
            'startTime': resultDoct[i]['availability'][j]['startTime'],
            'endTime': resultDoct[i]['availability'][j]['endTime'],
            'booked': resultDoct[i]['availability'][j]['booked'],
          };
          var res = ModelTime.fromMap(tempIndividual);
          temp.add(res);
        }
        doctorsTime.add(temp);
      }
      List<DoctorTimeModel> doctorTime = [];
      for (int i = 0; i < resultDoct.length; i++) {
        var temp = {
          'doctorName': resultDoct[i]['name'],
          'doctorID': resultDoct[i]['_id'],
          'departmentID': resultDoct[i]['department'],
          'consultationCharge': resultDoct[i]['consultationCharge'],
          'timeArray': doctorsTime[i],
        };
        var res = DoctorTimeModel.fromMap(temp);
        doctorTime.add(res);
      }
      emit(GetAppointmentDataLoadingSuccessState(
          deptModel: departments, doctorTimeModel: doctorTime));
    } else if (responseDept.statusCode == 404) {
      emit(GetAppointmentDataLoadingErrorState(
          errorMessage: "No Departments Found."));
    } else if (responseDoct.statusCode == 404) {
      emit(GetAppointmentDataLoadingErrorState(
          errorMessage: "No doctors found"));
    } else {
      emit(GetAppointmentDataLoadingErrorState(
          errorMessage: "Something went wrong"));
    }
  }

  FutureOr<void> bookAppointmentButtonClickedEvent(
      BookAppointmentButtonClickedEvent event,
      Emitter<GetAppointmentState> emit) async {
    var response = await UserNetworkRequests.bookAppointment(event.doctorId,
        event.deptId, event.selectedIndex.toString(), event.selectedSlot);
    if (response.statusCode == 200) {
      emit(BookAppointmentSuccessActionState());
    } else if (response.statusCode == 400) {
      emit(BookAppointmentErrorActionState(
          errorMessage: "All fields are required"));
    } else if (response.statusCode == 409) {
      emit(BookAppointmentErrorActionState(
          errorMessage: "This time slot has been booked"));
    } else {
      emit(BookAppointmentErrorActionState(
          errorMessage: "Something went wrong while booking the appointment"));
    }
  }
}
