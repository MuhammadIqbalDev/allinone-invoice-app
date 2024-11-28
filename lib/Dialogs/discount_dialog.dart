// import 'package:flutter/material.dart';

// class DiscountDialog extends StatefulWidget {
//   const DiscountDialog({super.key});

//   @override
//   State<DiscountDialog> createState() => _DiscountDialogState();
// }

// class _DiscountDialogState extends State<DiscountDialog> {
//   List<String> discount = <String>['No Discount', 'On total', 'Per item'];
//   String dropdownvalue = 'On total';

//   List<String> Type = <String>['Percentage', 'Flat Amount'];
//   String dropdownvalue2 = 'Percentage';

//   final TextEditingController _textFieldAmountController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//                   content: StatefulBuilder(builder: (context, setState) {
//                     return Form(
//                         child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Discount"),
//                         DropdownButton<String>(
//                           value: dropdownvalue,
//                           onChanged: (String? value) {
//                             // This is called when the user selects an item.
//                             setState(() {
//                               dropdownvalue = value!;
//                             });
//                           },
//                           items: discount
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         const Text("Type"),
//                         DropdownButton<String>(
//                           value: dropdownvalue2,
//                           onChanged: (String? value) {
//                             // This is called when the user selects an item.
//                             setState(() {
//                               dropdownvalue2 = value!;
//                             });
//                           },
//                           items: Type.map<DropdownMenuItem<String>>(
//                               (String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         const Text('Amount'),
//                         SizedBox(
//                           width: 200,
//                           height: 200,
//                           child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: _textFieldAmountController,
//                             decoration: const InputDecoration(
//                               prefixText: "\$",
//                             ),
//                           ),
//                         ),
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //   children: [
//                         //     ElevatedButton(
//                         //         onPressed: () {
//                         //           // log('Hello');
//                         //           Navigator.of(context).pop();
//                         //         },
//                         //         child: const Text('yes')),
//                         //     ElevatedButton(
//                         //         onPressed: () {
//                         //           // log('Hello');
//                         //           Navigator.of(context).pop();
//                         //         },
//                         //         child: const Text('Cancel'))
//                         //   ],
//                         // )
//                       ],
//                     ));
//                   }),
//                 ));
//       },
//       child: const Text("hello"),
//     );
//   }
// }
