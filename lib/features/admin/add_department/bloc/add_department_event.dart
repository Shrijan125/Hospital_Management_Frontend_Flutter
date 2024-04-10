part of 'add_department_bloc.dart';

@immutable
sealed class AddDepartmentEvent {}

class AddDepartmentButtonClickedEvent extends AddDepartmentEvent {
  final String deptName;

  AddDepartmentButtonClickedEvent({required this.deptName});
}
