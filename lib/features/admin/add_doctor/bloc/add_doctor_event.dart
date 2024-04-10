part of 'add_doctor_bloc.dart';

@immutable
sealed class AddDoctorEvent {}

class AddDoctorInitialEvent extends AddDoctorEvent {
  AddDoctorInitialEvent();
}

class AddDoctorButtonClickedEvent extends AddDoctorEvent {
  final String doctorName;
  final String email;
  final String phone;
  final String shortDescription;
  final String longDescription;
  final String consultaioncharge;
  final File? profilePhoto;
  final String departmentID;

  AddDoctorButtonClickedEvent(
      {required this.doctorName,
      required this.email,
      required this.phone,
      required this.shortDescription,
      required this.longDescription,
      required this.consultaioncharge,
      required this.profilePhoto,
      required this.departmentID});
}
