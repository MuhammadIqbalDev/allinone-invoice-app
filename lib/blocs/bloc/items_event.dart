// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'items_bloc.dart';

class ItemsEvent {
  ItemsEvent();
}

class getAllItems extends ItemsEvent {
  final List<AddItem> allItems;
  getAllItems({
    required this.allItems,
  });
}

class AddNew extends ItemsEvent {
  final AddItem item;
  AddNew({
    required this.item,
  });
}

class SelectedItems extends ItemsEvent {
  final List<AddItem>? selectedItem;
  SelectedItems({required this.selectedItem});
}

class defaultSelected extends ItemsEvent {}

class DeleteFromAllItems extends ItemsEvent {
  final AddItem item;
  DeleteFromAllItems(this.item);
}

class DeleteSelectedItems extends ItemsEvent {
  final AddItem selectedItem;
  DeleteSelectedItems(this.selectedItem);
}

class EditItems extends ItemsEvent {
  final AddItem editItem;
  EditItems({
    required this.editItem,
  });
}
