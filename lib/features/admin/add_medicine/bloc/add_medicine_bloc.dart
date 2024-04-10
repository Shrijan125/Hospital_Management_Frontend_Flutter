import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_medicine_event.dart';
part 'add_medicine_state.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {
  AddMedicineBloc() : super(AddMedicineInitial()) {
    on<AddMedicineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
