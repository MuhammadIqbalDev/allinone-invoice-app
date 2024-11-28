import 'package:flutter/material.dart';

class TaxDialog extends StatefulWidget {
  const TaxDialog({super.key});

  @override
  State<TaxDialog> createState() => _TaxDialogState();
}

class _TaxDialogState extends State<TaxDialog> {
  List<String> tax = <String>['No tax', 'On total', 'Per item'];
  String dropdownvalue1 = 'No tax';

  final TextEditingController _textFieldRateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: const Text("bye"),
    );
  }
  

}
