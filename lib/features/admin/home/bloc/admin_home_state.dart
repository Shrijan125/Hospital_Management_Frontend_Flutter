part of 'admin_home_bloc.dart';

@immutable
sealed class AdminHomeState {}

abstract class AdminHomeActionState extends AdminHomeState {}

final class AdminHomeInitial extends AdminHomeState {}

final class AdminLogoutActionState extends AdminHomeActionState {}

final class AddDoctorActionState extends AdminHomeActionState {}

final class AddDepartmentActionState extends AdminHomeActionState {}
