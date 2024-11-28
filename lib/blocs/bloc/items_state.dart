// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'items_bloc.dart';

class ItemsState {
  final List<AddItem> selectedItems;
  final List<AddItem> allItem;
  final AddItem? item;
  ItemsState({
    required this.selectedItems,
    required this.allItem,
    this.item,
  });
}
