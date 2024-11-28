// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_app/model/itemModel.dart';

import '../Constants/colors.dart';
import '../Widgets/textFormFieldWidget.dart';
import '../blocs/bloc/items_bloc.dart';
import '../invoice_home.dart';

// List<AddItem> itemss = [];

class NewItem extends StatefulWidget {
  final AddItem? item;
  final bool isModal;
  final AddItem? EditingItem;
  const NewItem({
    super.key,
    this.item,
    required this.isModal,
    this.EditingItem,
  });

  @override
  State<NewItem> createState() => _NewItemState();
  
}


class _NewItemState extends State<NewItem> {
   bool isDisabled = true; 
  @override
  void initState() {
    if (widget.item != null) {
      AddItem item = widget.item!;
      _textFieldItemNameController.text = item.itemName;
      _textFieldDescriptionController.text = item.description;
      _textFieldUnitPriceController.text = item.unitPrice.toString();
      _textFieldQuantityController.text = item.quantity.toString();
      defaultCat = item.category;
      Unitdropdownvalue = item.unit;
    } // TODO: implement initState
    super.initState();
  }

  final TextEditingController _textFieldItemNameController =
      TextEditingController();
  final TextEditingController _textFieldDescriptionController =
      TextEditingController();
  final TextEditingController _textFieldUnitPriceController =
      TextEditingController();
  final TextEditingController _textFieldQuantityController =
      TextEditingController();
  

  final _formKey = GlobalKey<FormState>();
  String Price = '0';
  String Quantity = '0';
  var result = 0;

  List<String> unit = <String>[
    'Kg',
    'lb',
    'g',
    'mg',
    't',
    'pcs'
  ];
  List<String> category = ['Goods', 'Services'];
  String defaultCat = 'Goods';
  String Unitdropdownvalue = 'pcs';

  double getSubtotal({required double quantity, required double unitPrice}) {
    return quantity * unitPrice;
  }

  double getTotalofAllItem({required List<AddItem> items}) {
    double total = 0.0;
    for (var element in items) {
      // if (element.total != null) {
      total += element.total;
      // }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double hieght = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Add new Item',
          style: tstyle(
              context: context, size: 20, fw: FontWeight.w600, color: black),
        ),
        actions: [
          BlocBuilder<ItemsBloc, ItemsState>(
            builder: (context, istate) {
              return TextButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                    } else {
                      // log('${istate.allItem}');
                      AddItem createdItem = AddItem(
                        selected_id: widget.isModal
                            ? istate.selectedItems.length + 1
                            : -1,
                        itemId: widget.EditingItem == null
                            ? istate.allItem.length + 1
                            : widget.EditingItem!.itemId,
                        itemName: _textFieldItemNameController.text,
                        description: _textFieldDescriptionController.text.isEmpty ? "No Description":_textFieldDescriptionController.text ,
                        unitPrice:
                            double.parse(_textFieldUnitPriceController.text),
                        unit: Unitdropdownvalue,
                        category: defaultCat,
                        taxable: false,
                        quantity: _textFieldQuantityController.text.isEmpty
                            ? 0
                            : int.parse(_textFieldQuantityController.text),
                        total: _textFieldQuantityController.text.isEmpty
                            ? 0
                            : int.parse(_textFieldQuantityController.text) *
                                double.parse(
                                    _textFieldUnitPriceController.text),
                      );
                      // if(_textFieldQuantityController.toString().isNotEmpty)
                      if (widget.isModal) {
                        context.read<ItemsBloc>().add(SelectedItems(
                            selectedItem: istate.selectedItems
                              ..add(createdItem)));
                        //  context.read<ItemsBloc>().add(AddNew(item: createdItem));
                      } else {
                        if (widget.EditingItem != null) {
                          context.read<ItemsBloc>().add(EditItems(
                              editItem: createdItem.copyWith(selected_id: -1)));
                        } else {
                          log("saved item : ${createdItem.itemId}");
                          context.read<ItemsBloc>().add(AddNew(
                              item: createdItem.copyWith(selected_id: -1)));
                        }
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "SAVE",
                    style: tstyle(
                      context: context,
                      size: 16,
                      fw: FontWeight.w400,
                      color: grey,
                    ),
                  ));
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                CustomTextFormField(
                   enabled: widget.isModal? false:true,
                  controller: _textFieldItemNameController,
                  labelText: "Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                    enabled: widget.isModal? false:true,
                    controller: _textFieldDescriptionController,
                    labelText: "Description (optional)"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: _textFieldUnitPriceController,
                          labelText: "Unit Price",
                          onSaved: (val) {
                            Price = val;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Unit Price';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    
                    SizedBox(
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: StatefulBuilder(builder: (context, setState) {
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                // style: const TextStyle(color: blackColor),
                                value: Unitdropdownvalue,
                                 onChanged: !widget.isModal?(String? value) {
                                  setState(() {
                                    Unitdropdownvalue = value!;
                                  });
                                }:null,
                                style: const TextStyle(color: blackColor),
                                decoration: InputDecoration(
                                  enabled: widget.isModal ?false :true,
                                    labelStyle: TextStyle(
                                        color: black.withOpacity(0.8)),
                                    labelText: 'Unit',
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: grey.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: grey.withOpacity(0.2)))),
                                items: unit.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: const TextStyle( // Set text color for all items here
                    color: blackColor, // Text color for all items
                  ),),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.4 ,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: StatefulBuilder(builder: (context, setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DropdownButtonFormField<String>(
                                value: defaultCat,
                                onChanged:!widget.isModal? (String? value) {
                                  setState(() {
                                    defaultCat = value!;
                                  });
                                }:null,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: black.withOpacity(0.5)),
                                    labelText: 'Category',
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: grey.withOpacity(0.2))),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: grey.withOpacity(0.2)))),
                                items: category.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: const TextStyle( // Set text color for all items here
                    color: blackColor, // Text color for all items
                  ),),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    // if (widget.isModal)
                      SizedBox(
                        width: width * 0.4,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              keyboardType: TextInputType.number,
                              controller: _textFieldQuantityController,
                              labelText: "Quantity",
                              onSaved: (val) {
                                Quantity = val;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Quanitity';
                                }
                                return null;
                              },
                            )),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
