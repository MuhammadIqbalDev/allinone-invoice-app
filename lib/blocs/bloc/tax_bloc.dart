
import 'package:bloc/bloc.dart';
import 'package:invoice_app/services/storage.dart';
// import 'package:meta/meta.dart';

import '../../model/taxModal.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  TaxBloc(Local_Storage st)
      : super(TaxState(
            allTax: [], selectedTax: AddTax(0, "No tax", "No tax", 0.0))) {
    on<getAllTax>((event, emit) {
      // final List<AddTax> allTax =
      //     state.allTax.isNotEmpty ?
      //     event.allTax : state.allTax;
      // log('event taxxx-------${event.allTax}');
      emit(TaxState(allTax: event.allTax, selectedTax: state.selectedTax));
    });
    on<AddNewTax>((event, emit) async {
      List<AddTax> allTax = [...state.allTax];
      allTax.add(event.tax);
      emit(TaxState(allTax: allTax, selectedTax: state.selectedTax));
      await st.saveTaxDetails(allTax);
    });
    on<SelectedTax>((event, emit) {
      AddTax selectedTax = event.selectedTax;
      emit(TaxState(allTax: state.allTax, selectedTax: selectedTax));
    });
    on<DeleteTax>((event, emit) {
      emit(TaxState(
          allTax: state.allTax
            ..removeWhere((element) => element.tax_id == event.tax.tax_id),
          selectedTax: state.selectedTax));
    });
    on<EditTax>((event, emit) {
      emit(TaxState(
          allTax: state.allTax
            ..removeWhere((element) => (element.tax_id == event.editTax.tax_id))
            ..add(event.editTax),
          selectedTax: state.selectedTax));
    });
  }
}
