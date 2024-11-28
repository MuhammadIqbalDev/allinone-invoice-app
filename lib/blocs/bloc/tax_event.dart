// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tax_bloc.dart';

class TaxEvent {
  TaxEvent();
}

class getAllTax extends TaxEvent {
  final List<AddTax> allTax;
  getAllTax({
    required this.allTax,
  });
}

class AddNewTax extends TaxEvent {
  final AddTax tax;
  AddNewTax({
    required this.tax,
  });
}

class SelectedTax extends TaxEvent {
  final AddTax selectedTax;

  SelectedTax({
    required this.selectedTax,
  });
}

class DeleteTax extends TaxEvent {
  final AddTax tax;

  DeleteTax(this.tax);
}

class EditTax extends TaxEvent {
  final AddTax editTax;
  EditTax({
    required this.editTax,
  });
}
