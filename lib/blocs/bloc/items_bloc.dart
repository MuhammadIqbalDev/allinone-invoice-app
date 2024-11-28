// import 'dart:html';

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:invoice_app/services/storage.dart';

import '../../model/itemModel.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc(Local_Storage st) : super(ItemsState(allItem: [], selectedItems: [])) {
    on<getAllItems>((event, emit) {
      final List<AddItem> allitem = event.allItems;
      emit(ItemsState(allItem: allitem, selectedItems: state.selectedItems));
    });
    on<AddNew>((event, emit) async {
      List<AddItem> allitem = [...state.allItem];
      allitem.add(event.item);

      emit(ItemsState(allItem: allitem, selectedItems: state.selectedItems));
      await st.saveItemDetails(allitem);
    });
    on<SelectedItems>((event, emit) {
      List<AddItem> allitem = event.selectedItem!;
      emit(ItemsState(allItem: state.allItem, selectedItems: allitem));
    });
    on<defaultSelected>(
      (event, emit) {
        emit(ItemsState(allItem: state.allItem, selectedItems: []));
      },
    );
    on<DeleteFromAllItems>((event, emit) async {
      List<AddItem> itemslist = state.allItem;

      emit(ItemsState(
          allItem: itemslist
            ..removeWhere((element) => element.itemId == event.item.itemId),
          selectedItems: state.selectedItems));

      await st.saveItemDetails(itemslist);
    });
    on<DeleteSelectedItems>((event, emit) {
      log( " ${state.selectedItems} \n getted selected item : ${event.selectedItem}");
      emit(ItemsState(
          selectedItems: state.selectedItems
            ..removeWhere((element) =>
                element.selected_id == event.selectedItem.selected_id),
          allItem: state.allItem));
    });
    on<EditItems>((event, emit) {
      emit(ItemsState(
          selectedItems: state.selectedItems,
          allItem: state.allItem
            ..removeWhere(
                (element) => (element.itemId == event.editItem.itemId))
            ..add(event.editItem),
          item: state.item));
    });
  }
}
