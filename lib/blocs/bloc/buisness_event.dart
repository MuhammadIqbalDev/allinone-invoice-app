// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'buisness_bloc.dart';

abstract class BuisnessEvent {
  BuisnessEvent();
}

class AddBuisness extends BuisnessEvent {
  final Business_Info buisness;
  AddBuisness({required this.buisness});
}

class AllBuisness extends BuisnessEvent {
  final List<Business_Info> buisnessList;
  AllBuisness({required this.buisnessList});
}

class selectedBuisness extends BuisnessEvent {
  final Business_Info? sb;
  selectedBuisness({
    required this.sb,
  });
}

class DeleteBuisness extends BuisnessEvent {
  final int index;
  DeleteBuisness(this.index);
}

class EditBusiness extends BuisnessEvent {
  final Business_Info editBusiness;
  EditBusiness({
    required this.editBusiness,
  });
}
