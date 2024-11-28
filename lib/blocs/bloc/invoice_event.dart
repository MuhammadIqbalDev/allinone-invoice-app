// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invoice_bloc.dart';

 class InvoiceEvent {
  InvoiceEvent();
}

class AddInvoice extends InvoiceEvent {
  final InvoiceModel invoice;
  AddInvoice({required this.invoice});
}

class GetAllInvoice extends InvoiceEvent {
  final List<InvoiceModel> allInvoices;
  GetAllInvoice({required this.allInvoices});
}

class SelectedInvoice extends InvoiceEvent {
  final InvoiceModel selectedInvoice;
  SelectedInvoice({
    required this.selectedInvoice,
  });
}

class DeleteInvoices extends InvoiceEvent {
  final InvoiceModel invoice;
  DeleteInvoices(this.invoice);
}
class EditInvoices extends InvoiceEvent {
  final InvoiceModel editInvoice;
  EditInvoices({
    required this.editInvoice,
  });


}
