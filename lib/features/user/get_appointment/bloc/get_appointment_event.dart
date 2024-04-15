part of 'get_appointment_bloc.dart';

@immutable
sealed class GetAppointmentEvent {}

class GetAppointmentInitialEvent extends GetAppointmentEvent {}

class BookAppointmentButtonClickedEvent extends GetAppointmentEvent {
  final String deptId;
  final String doctorId;
  final String selectedSlot;
  final int selectedIndex;
  BookAppointmentButtonClickedEvent(
      {required this.deptId,
      required this.doctorId,
      required this.selectedSlot,
      required this.selectedIndex});
}
