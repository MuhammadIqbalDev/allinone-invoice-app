// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:invoice_app/model/taxModal.dart';
// import 'package:mongo_dart/mongo_dart.dart';

import '../blocs/bloc/tax_bloc.dart';

class AddTaxDialog extends StatefulWidget {
  final AddTax? EditingTax;
  const AddTaxDialog({
    super.key,
    this.EditingTax,
  });

  @override
  State<AddTaxDialog> createState() => _AddTaxDialogState();
}

List<String> tax = <String>['No tax', 'On total', 'Per item'];
String dropdownvalue1 = 'No tax';

final TextEditingController _textFieldRateController = TextEditingController();

class _AddTaxDialogState extends State<AddTaxDialog> {
  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<TaxBloc, TaxState>(
      builder: (context, tstate) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text("Tax"),
                  DropdownButton<String>(
                    value: dropdownvalue1,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        // dropdownvalue1 = value!;
                      });
                    },
                    items: tax.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Text('Rate'),
                  SizedBox(
                    // width: 200,
                    // height: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _textFieldRateController,
                      decoration: const InputDecoration(
                        hintText: "0.0",
                        suffixText: "%",
                      ),
                    ),
                  ),
                ],
              ));
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                // AddTax createdTax = AddTax(
                //     widget.EditingTax != null
                //         ? widget.EditingTax!.tax_id
                //         : tstate.allTax.length + 1,

                //     _textFieldRateController.text,
                //     _
                //     );

                setState(() {
                  context.read<TaxBloc>().add(AddNewTax(
                      tax: AddTax(
                          tstate.allTax.length + 1, "", dropdownvalue1, 0)));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
