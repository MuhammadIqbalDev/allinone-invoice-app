// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_app/Widgets/textFormFieldWidget.dart';
import 'package:invoice_app/blocs/bloc/tax_bloc.dart';

import 'Constants/colors.dart';
import 'Widgets/my_widgets/my_drawer.dart';
import 'invoice_home.dart';
import 'model/taxModal.dart';

class TaxHome extends StatefulWidget {
  final AddTax? tax;
  final bool isModal;
  const TaxHome({
    super.key,
    required this.tax,
    required this.isModal,
  });

  @override
  State<TaxHome> createState() => _TaxtHomeState();
}

List<String> tax = <String>['No tax', 'On total', 'Per item'];
String dropdownvalue1 = 'No tax';

final TextEditingController _textFieldRateController = TextEditingController();
final TextEditingController _textFieldTaxLabelController =
    TextEditingController();
final _formKey = GlobalKey<FormState>();
double taxpercent = 0;

class _TaxtHomeState extends State<TaxHome> {
  bool isModal = false;
  @override
  void initState() {
    isModal = widget.isModal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Taxes',
            style: tstyle(size: 25, context: context, fw: FontWeight.bold),
          ),
        ),
        drawer: !isModal ? MyDrawer(existingCxt: context) : null,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<TaxBloc, TaxState>(builder: (context, state) {
                return Container(
                  child: state.allTax.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.allTax.length,
                          itemBuilder: ((context, index) {
                            AddTax tax = state.allTax[index];
                            // log('statealltax---$tax');
                            return InkWell(
                              onTap: () {
                                // log("i am tapperd");
                                if (isModal) {
                                  context
                                      .read<TaxBloc>()
                                      .add(SelectedTax(selectedTax: tax));
                                  Navigator.of(context).pop();
                                } else {}
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(tax.taxLabel,
                                                style: tstyle(
                                                    context: context,
                                                    fw: FontWeight.w500,
                                                    size: 20)),
                                            Text(tax.taxType,
                                                style: tstyle(
                                                    context: context,
                                                    fw: FontWeight.w400,
                                                    size: 16)),
                                            // const Text(''),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    '${tax.taxPercentage.toString()}'
                                                    '${"%"}'),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(
                                                              color: grey
                                                                  .withOpacity(
                                                                      0.8)))),
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: primary),
                                                    onPressed: () {
                                                      context
                                                          .read<TaxBloc>()
                                                          .add(DeleteTax(tax));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: greyLight,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                      : Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Image(
                                  image:
                                      const AssetImage('assets/images/tax.png'),
                                  height: hieght * 0.44,
                                ),
                                // const SizedBox(
                                //   height: 1,
                                // ),
                                //  if(!widget.isModal)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Taxes!",
                                        style: tstyle(
                                            size: 25,
                                            context: context,
                                            fw: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Please tap on the plus (+) button bellow to create a Tax.",
                                        style: tstyle(
                                          context: context,
                                          size: 20,
                                          // color: grey.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                );
              }),
              const SizedBox(
                height: 500,
              ),
            ],
          ),
        )),
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(50), // Customize the border radius here
            ),
            onPressed: () {
              _Taxdialog(context);
            },

            child: Icon(
              Icons.add,
              color: white,
              size: 30,
            ), // Customize the button color here
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<void> _Taxdialog(BuildContext context) {
    final AddTax? Editingtax;
    double hieght = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return showDialog(
      context: context,
      builder: (context) => BlocBuilder<TaxBloc, TaxState>(
        builder: (context, state) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (context, setState) {
                return Form(
                  child: SizedBox(
                    height: hieght * 0.4,
                    width: width * 0.6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 300,
                            child: CustomTextFormField(
                              controller: _textFieldTaxLabelController,
                              labelText: "Tax Label",
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Type"),
                        SizedBox(
                          width: 300,
                          child: DropdownButton<String>(
                            value: dropdownvalue1,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownvalue1 = value!;
                              });
                            },
                            items: tax
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // const Text('Rate'),
                        SizedBox(
                            height: hieght * 0.1,
                            width: 300,
                            child: CustomTextFormField(
                              controller: _textFieldRateController,
                              labelText: 'Rate',
                              keyboardType: TextInputType.number,
                              suffixText: '%',
                              
                            )
                            // TextFormField(
                            //   style: TextStyle(color:black),
                            //   keyboardType: TextInputType.number,
                            //   controller: _textFieldRateController,
                            //   decoration: const InputDecoration(
                            //     hintText: "0.0",
                            //     suffixText: "%",
                            //     focusColor: blackColor
                            //   ),
                            // ),
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'No',
                  style: TextStyle(color: primary),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: primary),
                ),
                onPressed: () {
                  AddTax createdTax = AddTax(
                      state.allTax.length + 1,
                      _textFieldTaxLabelController.text,
                      dropdownvalue1,
                      double.parse(_textFieldRateController.text));

                  context.read<TaxBloc>().add(AddNewTax(tax: createdTax));
                  context
                      .read<TaxBloc>()
                      .add(SelectedTax(selectedTax: createdTax));

                  setState(() {
                    taxpercent = double.parse(_textFieldRateController.text);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
