part of 'user_appointment_bloc.dart';

@immutable
sealed class UserAppointmentState {}

final class UserAppointmentInitial extends UserAppointmentState {}

abstract class UserAppointmentActionState extends UserAppointmentState {}

final class NavigateToBookAppointmentPageActionState
    extends UserAppointmentActionState {}

class UserAppointmentLoadingState extends UserAppointmentState {}

class UserAppointmentLoadingSuccessState extends UserAppointmentState {
  final List<AppointmentModel> appoinments;

  UserAppointmentLoadingSuccessState({required this.appoinments});
}

class UserAppointmentLoadingErrorState extends UserAppointmentState {
  final String errorMessage;

  UserAppointmentLoadingErrorState({required this.errorMessage});
}
