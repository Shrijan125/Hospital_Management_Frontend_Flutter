part of 'get_appointment_bloc.dart';

@immutable
sealed class GetAppointmentState {}

final class GetAppointmentInitial extends GetAppointmentState {}

abstract class GetAppointmentActionState extends GetAppointmentState {}

class GetAppointmentDataLoadingState extends GetAppointmentState {}

class GetAppointmentDataLoadingSuccessState extends GetAppointmentState {
  final List<DeptModel> deptModel;
  final List<DoctorTimeModel> doctorTimeModel;
  GetAppointmentDataLoadingSuccessState({
    required this.deptModel,
    required this.doctorTimeModel,
  });
}

class GetAppointmentDataLoadingErrorState extends GetAppointmentState {
  final String errorMessage;

  GetAppointmentDataLoadingErrorState({required this.errorMessage});
}

class BookAppointmentSuccessActionState extends GetAppointmentActionState {}

class BookAppointmentErrorActionState extends GetAppointmentActionState {
  final String errorMessage;

  BookAppointmentErrorActionState({required this.errorMessage});
}
