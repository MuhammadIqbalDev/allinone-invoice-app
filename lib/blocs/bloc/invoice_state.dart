// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invoice_bloc.dart';

class InvoiceState {
  final List<InvoiceModel> invoiceList;
  final InvoiceModel? selectedInvoices;
  InvoiceState({
    required this.invoiceList,
    required this.selectedInvoices,
  });
}
