part of 'admin_home_bloc.dart';

@immutable
sealed class AdminHomeEvent {}

class AdminLogoutButtonCLickedEvent extends AdminHomeEvent {}

class AddDoctorButtonClickedEvent extends AdminHomeEvent {}

class AddDepartmentButtonClickedEvent extends AdminHomeEvent {}

class AddMedCategoryButtonClickedEvent extends AdminHomeEvent {}

class AddMedicineButtonClickedEvent extends AdminHomeEvent {}
