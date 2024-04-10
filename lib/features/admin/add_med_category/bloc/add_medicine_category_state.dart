part of 'add_medicine_category_bloc.dart';

@immutable
sealed class AddMedicineCategoryState {}

final class AddMedicineCategoryInitial extends AddMedicineCategoryState {}

abstract class AddMedicinCategoryActionState extends AddMedicineCategoryState {}

class AddMedicineCategorySuccessActionState
    extends AddMedicinCategoryActionState {}

class AddMedicineCategoryErrorActionState
    extends AddMedicinCategoryActionState {
  final String errorMessage;

  AddMedicineCategoryErrorActionState({required this.errorMessage});
}

class AddMedicineCategoryLoadingState extends AddMedicineCategoryState {}
