// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:invoice_app/main.dart';
import 'package:invoice_app/model/itemModel.dart';
import '../Constants/colors.dart';

import '../Widgets/textFormFieldWidget.dart';
import '../invoice_home.dart';

List<AddItem> itemss = [];

class InvoiceItem extends StatefulWidget {
  const InvoiceItem({
    Key? key,
  }) : super(key: key);

  @override
  State<InvoiceItem> createState() => _InvoiceItemState();
}

class _InvoiceItemState extends State<InvoiceItem> {
  final TextEditingController _textFieldItemNameController =
      TextEditingController();
  final TextEditingController _textFieldDescriptionController =
      TextEditingController();
  final TextEditingController _textFieldUnitPriceController =
      TextEditingController();
  final TextEditingController _textFieldUnitController =
      TextEditingController();
  final TextEditingController _textFieldQuantityController =
      TextEditingController();
  String Price = '0';
  String Quantity = '0';
  var result = 0;

  List<String> unit = <String>['Kg', 'lb'];
  String Unitdropdownvalue = 'Kg';

  // double getSubtotal({required double quantity, required double unitPrice}) {
  //   return quantity * unitPrice;
  // }

  // double getTotalofAllItem({required List<AddItem> items}) {
  //   double total = 0.0;
  //   for (var element in items) {
  //     total += element.total;
  //   }
  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
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
          style: tstyle(context: context,size: 20, fw: FontWeight.w600,color: black),
        ),
        actions: [
          TextButton(onPressed: (){

          }, child: Text("SAVE",style: tstyle(context: context,size: 16,fw: FontWeight.w400,color: grey,),))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              CustomTextFormField(
                controller: _textFieldItemNameController,
                labelText: "Name",
              ),
              CustomTextFormField(
                  controller: _textFieldDescriptionController,
                  labelText: "Description (optional)"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        keyboardType: TextInputType.number,
                        controller: _textFieldUnitPriceController,
                        labelText: "Unit Price",
                        onSaved: (val) {
                          Price = val;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DropdownButtonFormField<String>(
                              value: Unitdropdownvalue,
                              onChanged: (String? value) {
                                setState(() {
                                  Unitdropdownvalue = value!;
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(color: primary),
                                labelText: 'Unit',
                              ),
                              items: unit.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: _textFieldQuantityController,
                          labelText: "Quantity",
                          onSaved: (val) {
                            Quantity = val;
                          },
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
