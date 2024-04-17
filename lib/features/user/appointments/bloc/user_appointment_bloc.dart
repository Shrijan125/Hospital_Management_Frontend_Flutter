import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fontend/features/user/appointments/models/appointment_model.dart';
import 'package:fontend/network/user/user_network_request.dart';
import 'package:meta/meta.dart';

part 'user_appointment_event.dart';
part 'user_appointment_state.dart';

class UserAppointmentBloc
    extends Bloc<UserAppointmentEvent, UserAppointmentState> {
  UserAppointmentBloc() : super(UserAppointmentInitial()) {
    on<BookAppointmentButtonClickedEvent>(bookAppointmentButtonClickedEvent);
    on<AppointmentInitialEvent>(appointmentInitialEvent);
  }

  FutureOr<void> bookAppointmentButtonClickedEvent(
      BookAppointmentButtonClickedEvent event,
      Emitter<UserAppointmentState> emit) {
    emit(NavigateToBookAppointmentPageActionState());
  }

  FutureOr<void> appointmentInitialEvent(
      AppointmentInitialEvent event, Emitter<UserAppointmentState> emit) async {
    emit(UserAppointmentLoadingState());
    var responseAppointment = await UserNetworkRequests.getAppoinments();

    if (responseAppointment.statusCode == 200) {
      List<dynamic> result = jsonDecode(responseAppointment.body)['data'];
      List<AppointmentModel> appointment = [];
      for (int i = 0; i < result.length; i++) {
        var temp = {
          'doctorName': result[i]['doctorName'],
          'profilePhoto': result[i]['doctorProfilePhoto'],
          'time': result[i]['timeSlot']
        };
        var res = AppointmentModel.fromMap(temp);
        appointment.add(res);
      }

      emit(UserAppointmentLoadingSuccessState(appoinments: appointment));
    } else if (responseAppointment.statusCode == 404) {
      emit(UserAppointmentLoadingSuccessState(appoinments: const []));
    } else {
      emit(UserAppointmentLoadingErrorState(
          errorMessage: "Falied to get appointments"));
    }
  }
}
