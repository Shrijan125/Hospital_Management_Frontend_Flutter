part of 'user_appointment_bloc.dart';

@immutable
sealed class UserAppointmentEvent {}

class BookAppointmentButtonClickedEvent extends UserAppointmentEvent {}

class AppointmentInitialEvent extends UserAppointmentEvent {}
