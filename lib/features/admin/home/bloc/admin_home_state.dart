part of 'admin_home_bloc.dart';

@immutable
sealed class AdminHomeState {}

abstract class AdminHomeActionState extends AdminHomeState {}

final class AdminHomeInitial extends AdminHomeState {}

class AdminLogoutActionState extends AdminHomeActionState {}

class AddDoctorActionState extends AdminHomeActionState {}

class AddDepartmentActionState extends AdminHomeActionState {}

class AddMedCategoryActionState extends AdminHomeActionState {}

class AddMedicineActionState extends AdminHomeActionState {}
