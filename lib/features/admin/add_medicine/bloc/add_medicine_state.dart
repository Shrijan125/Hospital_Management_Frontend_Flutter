part of 'add_medicine_bloc.dart';

@immutable
sealed class AddMedicineState {}

final class AddMedicineInitial extends AddMedicineState {}

abstract class AddMedicineActionState extends AddMedicineState {}

class DataLoadingErrorState extends AddMedicineState {
  final String errorMessage;

  DataLoadingErrorState({required this.errorMessage});
}

class DataLoadedSuccessState extends AddMedicineState {
  final List<MedicineCategory> categoryName;

  DataLoadedSuccessState({required this.categoryName});
}

class AddedMedicineSuccessActionState extends AddMedicineActionState {}

class AddMedicineErrorActionState extends AddMedicineActionState {
  final String errorMessage;

  AddMedicineErrorActionState({required this.errorMessage});
}
