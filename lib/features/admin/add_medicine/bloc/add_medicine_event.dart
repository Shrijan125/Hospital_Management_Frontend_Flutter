part of 'add_medicine_bloc.dart';

@immutable
sealed class AddMedicineEvent {}

class AddMedicineInitialEvent extends AddMedicineEvent {}

class AddMedicineButtonClickedEvent extends AddMedicineEvent {
  final String medicineName;
  final String mfg;
  final String exp;
  final String selectedCategory;
  final String unitPrice;
  final String prescriptionRequired;
  final File? medicineImg;

  AddMedicineButtonClickedEvent(
      {required this.medicineName,
      required this.mfg,
      required this.exp,
      required this.selectedCategory,
      required this.unitPrice,
      required this.prescriptionRequired,
      this.medicineImg});
}
