// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tax_bloc.dart';

class TaxState {
  final List<AddTax> allTax;
  final AddTax selectedTax;

  TaxState({
    required this.allTax,
    required this.selectedTax, 
  });
}
