import 'package:bloc/bloc.dart';
import 'package:invoice_app/model/addnewInvoice.dart';
import 'package:invoice_app/services/storage.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc(Local_Storage st)
      : super(InvoiceState(invoiceList: [], selectedInvoices: null)) {
    on<AddInvoice>((event, emit) async {
      // state.invoiceList.isNotEmpty ? state.invoiceList.clear() : null;
      List<InvoiceModel> newList = state.invoiceList;
      newList.add(event.invoice);
      emit(InvoiceState(
          invoiceList: newList, selectedInvoices: state.selectedInvoices));
        
      await st.saveInvoiceDetails(newList);
    });
    on<GetAllInvoice>((event, emit) {
      // List<InvoiceModel> newList = event.allInvoices;

      emit(InvoiceState(
          invoiceList: event.allInvoices,
          selectedInvoices: state.selectedInvoices));
    });
    on<SelectedInvoice>((event, emit) {
      // final InvoiceModel selectedInvoice = event.selectedInvoice;
      // List<InvoiceModel> invoices = state.invoiceList;
      // allinvoices.add(selectedInvoice);
      emit(InvoiceState(
          invoiceList: state.invoiceList,
          selectedInvoices: event.selectedInvoice));
    });
    on<DeleteInvoices>(((event, emit) async {
      List<InvoiceModel> allinvoices = state.invoiceList;
      allinvoices.remove(event.invoice);

      emit(InvoiceState(
          invoiceList: allinvoices, selectedInvoices: state.selectedInvoices));
      await st.saveInvoiceDetails(allinvoices);
    }));
    on<EditInvoices>(
      (event, emit) {
        emit(InvoiceState(
            invoiceList: state.invoiceList
              ..removeWhere((element) =>
                  (element.invoice_id == event.editInvoice.invoice_id))
              ..add(event.editInvoice),
            selectedInvoices: state.selectedInvoices));
      },
    );
  }
}
