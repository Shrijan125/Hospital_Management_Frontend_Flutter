part of 'add_medicine_category_bloc.dart';

@immutable
sealed class AddMedicineCategoryEvent {}

class AddMedicineButtonClickedEvent extends AddMedicineCategoryEvent {
  final String categoryName;

  AddMedicineButtonClickedEvent({required this.categoryName});
}
