part of 'add_department_bloc.dart';

@immutable
sealed class AddDepartmentState {}

final class AddDepartmentInitial extends AddDepartmentState {}

abstract class AddDepartmentActionState extends AddDepartmentState {}

class AddDepartmentLoadingState extends AddDepartmentState {}

class AddDepartmentSuccessState extends AddDepartmentActionState {}

class AddDepartmentErrorState extends AddDepartmentActionState {
  final String errorMessage;

  AddDepartmentErrorState(this.errorMessage);
}
