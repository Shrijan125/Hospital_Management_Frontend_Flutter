import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_appointment_event.dart';
part 'user_appointment_state.dart';

class UserAppointmentBloc
    extends Bloc<UserAppointmentEvent, UserAppointmentState> {
  UserAppointmentBloc() : super(UserAppointmentInitial()) {
    on<BookAppointmentButtonClickedEvent>(bookAppointmentButtonClickedEvent);
  }

  FutureOr<void> bookAppointmentButtonClickedEvent(
      BookAppointmentButtonClickedEvent event,
      Emitter<UserAppointmentState> emit) {
    emit(NavigateToBookAppointmentPageActionState());
  }
}
