part of 'add_doctor_bloc.dart';

@immutable
sealed class AddDoctorState {}

final class AddDoctorInitial extends AddDoctorState {}

abstract class AddDoctorActionState extends AddDoctorState {}

class DataLoadedSuccessState extends AddDoctorState {
  final List<DeptModel> deptName;
  DataLoadedSuccessState({
    required this.deptName,
  });
}

class DataLoadingErrorState extends AddDoctorState {
  final String errorMessage;

  DataLoadingErrorState({required this.errorMessage});
}

class AddingDoctorSuccessActionState extends AddDoctorActionState {}

class AddingDoctorErrorActionState extends AddDoctorActionState {
  final String errorMessage;
  AddingDoctorErrorActionState({
    required this.errorMessage,
  });
}
