part of 'user_appointment_bloc.dart';

@immutable
sealed class UserAppointmentState {}

final class UserAppointmentInitial extends UserAppointmentState {}

abstract class UserAppointmentActionState extends UserAppointmentState {}

final class NavigateToBookAppointmentPageActionState
    extends UserAppointmentActionState {}
