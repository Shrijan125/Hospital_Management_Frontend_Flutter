import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fontend/features/admin/add_doctor/models/department_model.dart';
import 'package:fontend/network/user/user_network_request.dart';
import 'package:meta/meta.dart';

import '../model/doctor_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<UserProfileButtonCLickedEvent>(userProfileButtonCLickedEvent);
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> userProfileButtonCLickedEvent(
      UserProfileButtonCLickedEvent event, Emitter<HomeState> emit) {
    emit(NavigateToUserProfileActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeDoctorLoadingState());
    var resposne = await UserNetworkRequests.getDoctors();
    var responseDept = await UserNetworkRequests.getDepartmentUser();
    if (resposne.statusCode == 200 && responseDept.statusCode == 200) {
      List<dynamic> result = jsonDecode(resposne.body)['data'];
      List<DoctorModel> doctors = [];
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
      for (int i = 0; i < result.length; i++) {
        var temp = {
          'name': result[i]['name'],
          'profilePhoto': result[i]['profilePhoto'],
          'shortDescription': result[i]['shortDescription'],
          'department': departments
              .firstWhere(
                (dept) => dept.deptID == result[i]['department'],
              )
              .deptName,
        };
        var res = DoctorModel.fromMap(temp);
        doctors.add(res);
      }
      emit(HomeDoctorLoadingSuccessState(doctorModel: doctors));
    } else {
      emit(HomeDoctorLoadingErrorState());
    }
  }
}
