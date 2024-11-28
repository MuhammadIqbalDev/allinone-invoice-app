// import 'package:flutter/material.dart';
// import 'package:invoice_app/ItemsHome.dart';
// import 'package:invoice_app/businessHome.dart';
// import 'package:invoice_app/categories.dart';
// import 'package:invoice_app/clients_home.dart';
// import 'package:invoice_app/invoice_home.dart';
// import 'package:invoice_app/tax_home.dart';

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});

//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   List<String> discount = <String>['No Discount', 'On total', 'Per item'];
//   String dropdownvalue = 'On total';

//   List<String> Type = <String>['Percentage', 'Flat Amount'];
//   String dropdownvalue2 = 'Percentage';

//   @override
//   void initState() {
//     super.initState();
//   }

//   int startInvoiceNumber = 1;
//   int endInvoiceNumber = 10;
//   double resultSubTotal = 0;
//   double discountpercent = 0;
//   double taxpercent = 0;

//   // double result = 0;

//   List<String> unit = <String>[];
//   // ['Kg', 'lb'];
//   String Unitdropdownvalue = 'kg';

//   List<String> tax = <String>['No tax', 'On total', 'Per item'];
//   String dropdownvalue1 = 'No tax';

//   final TextEditingController _textFieldRateController =
//       TextEditingController();
//   final TextEditingController _textFieldAmountController =
//       TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.sizeOf(context).width;
//     double hieght = MediaQuery.sizeOf(context).width;
//     return SafeArea(
//       child: SizedBox(
//         width: width * 0.7,
//         child: Scaffold(
//           body: Column(
//             children: [
//               Image(
//                 image: const AssetImage('assets/images/logo.png'),
//                 height: hieght * 0.4,
//               ),
//               // const SizedBox(
//               //   height: 20,
//               // ),
//               const Divider(height: 2, thickness: 2),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const InvoiceHome();
//                   }));
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.inventory_rounded),
//                   title: Text('Invoices'),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const ClientsHome();
//                   }));
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.book_outlined),
//                   title: Text('Clients'),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const ItemsHome(isModal: false);
//                   }));
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.shopping_bag_outlined),
//                   title: Text('Items'),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const TaxHome(tax: null, isModal: false);
//                   }));
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.file_copy_outlined),
//                   title: Text('Tax'),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const BusinessHome(isModal: false);
//                   }));
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.business),
//                   title: Text('Business'),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const CategoriesScreen();
//                   }));
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.category_outlined),
//                   title: Text('Categories'),
//                 ),
//               ),
//               // InkWell(
//               //   onTap: () {
//               //     showDialog(
//               //       context: context,
//               //       builder: (context) => AlertDialog(
//               //         content: StatefulBuilder(
//               //           builder: (context, setState) {
//               //             return Form(
//               //               child: Column(
//               //                 mainAxisSize: MainAxisSize.min,
//               //                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                 children: [
//               //                   const Text("Tax"),
//               //                   DropdownButton<String>(
//               //                     value: dropdownvalue1,
//               //                     onChanged: (String? value) {
//               //                       // This is called when the user selects an item.
//               //                       setState(() {
//               //                         dropdownvalue1 = value!;
//               //                       });
//               //                     },
//               //                     items: tax.map<DropdownMenuItem<String>>(
//               //                         (String value) {
//               //                       return DropdownMenuItem<String>(
//               //                         value: value,
//               //                         child: Text(value),
//               //                       );
//               //                     }).toList(),
//               //                   ),
//               //                   const SizedBox(
//               //                     height: 10,
//               //                   ),
//               //                   const Text('Rate'),
//               //                   SizedBox(
//               //                     // width: 200,
//               //                     // height: 200,
//               //                     child: TextFormField(
//               //                       keyboardType: TextInputType.number,
//               //                       controller: _textFieldRateController,
//               //                       decoration: const InputDecoration(
//               //                         hintText: "0.0",
//               //                         suffixText: "%",
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 ],
//               //               ),
//               //             );
//               //           },
//               //         ),
//               //         actions: <Widget>[
//               //           TextButton(
//               //             child: const Text('No'),
//               //             onPressed: () {
//               //               Navigator.of(context).pop();
//               //             },
//               //           ),
//               //           TextButton(
//               //             child: const Text('Yes'),
//               //             onPressed: () {
//               //               setState(() {
//               //                 taxpercent =
//               //                     double.parse(_textFieldRateController.text);
//               //               });
//               //               Navigator.of(context).pop();
//               //             },
//               //           ),
//               //         ],
//               //       ),
//               //     );
//               //   },
//               //   child: const ListTile(
//               //     leading: Icon(Icons.file_copy_outlined),
//               //     title: Text('Tax'),
//               //   ),
//               // ),
//               // InkWell(
//               //   onTap: () {
//               //     showDialog(
//               //       context: context,
//               //       builder: (context) => AlertDialog(
//               //         content: StatefulBuilder(builder: (context, setState) {
//               //           return Form(
//               //               child: Column(
//               //             mainAxisSize: MainAxisSize.min,
//               //             // mainAxisAlignment: MainAxisAlignment.start,
//               //             crossAxisAlignment: CrossAxisAlignment.start,
//               //             children: [
//               //               const Text("Discount"),
//               //               DropdownButton<String>(
//               //                 value: dropdownvalue,
//               //                 onChanged: (String? value) {
//               //                   // This is called when the user selects an item.
//               //                   setState(() {
//               //                     dropdownvalue = value!;
//               //                   });
//               //                 },
//               //                 items: discount.map<DropdownMenuItem<String>>(
//               //                     (String value) {
//               //                   return DropdownMenuItem<String>(
//               //                     value: value,
//               //                     child: Text(value),
//               //                   );
//               //                 }).toList(),
//               //               ),
//               //               const Text("Type"),
//               //               DropdownButton<String>(
//               //                 value: dropdownvalue2,
//               //                 onChanged: (String? value) {
//               //                   // log('dropdownvalue : $value');
//               //                   // This is called when the user selects an item.
//               //                   setState(() {
//               //                     dropdownvalue2 = value!;
//               //                   });
//               //                 },
//               //                 items: Type.map<DropdownMenuItem<String>>(
//               //                     (String value) {
//               //                   return DropdownMenuItem<String>(
//               //                     value: value,
//               //                     child: Text(value),
//               //                   );
//               //                 }).toList(),
//               //               ),
//               //               const Text('Amount'),
//               //               SizedBox(
//               //                 // width: 200,
//               //                 // height: 200,
//               //                 child: TextFormField(
//               //                   keyboardType: TextInputType.number,
//               //                   controller: _textFieldAmountController,
//               //                   decoration: InputDecoration(
//               //                     prefixText: (dropdownvalue2 == "Flat Amount")
//               //                         ? "\$"
//               //                         : null,
//               //                     suffixText: (dropdownvalue2 != "Flat Amount")
//               //                         ? "%"
//               //                         : null,
//               //                   ),
//               //                 ),
//               //               ),

//               //             ],
//               //           ));
//               //         }),
//               //         actions: <Widget>[
//               //           TextButton(
//               //             child: const Text('No'),
//               //             onPressed: () {
//               //               Navigator.of(context).pop();
//               //             },
//               //           ),
//               //           TextButton(
//               //             child: const Text('Yes'),
//               //             onPressed: () {
//               //               setState(() {
//               //                 discountpercent =
//               //                     double.parse(_textFieldAmountController.text);
//               //               });
//               //               Navigator.of(context).pop();
//               //             },
//               //           ),
//               //         ],
//               //       ),
//               //     );
//               //   },
//               //   child: const ListTile(
//               //     leading: Icon(Icons.discount_outlined),
//               //     title: Text('Discount'),
//               //   ),
//               // ),
//               // InkWell(
//               //   onTap: () {
//               //     showDialog(
//               //       context: context,
//               //       builder: (context) => AlertDialog(
//               //         content: StatefulBuilder(builder: (context, setState) {
//               //           return SizedBox(
//               //             width: width * 0.6,
//               //             height: hieght * 0.4,
//               //             child: Column(
//               //               // crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 DropdownButtonFormField<String>(
//               //                   value: Unitdropdownvalue,
//               //                   onChanged: (String? value) {
//               //                     setState(() {
//               //                       Unitdropdownvalue = value!;
//               //                     });
//               //                   },
//               //                   decoration: InputDecoration(
//               //                       labelStyle: TextStyle(
//               //                           color: black.withOpacity(0.8)),
//               //                       labelText: 'Unit',
//               //                       border: UnderlineInputBorder(
//               //                           borderSide: BorderSide(
//               //                               color: grey.withOpacity(0.2))),
//               //                       focusedBorder: UnderlineInputBorder(
//               //                           borderSide: BorderSide(
//               //                               color: grey.withOpacity(0.2)))),
//               //                   items: unit.map<DropdownMenuItem<String>>(
//               //                       (String value) {
//               //                     return DropdownMenuItem<String>(
//               //                       value: value,
//               //                       child: Text(value),
//               //                     );
//               //                   }).toList(),
//               //                 ),
//               //                 const SizedBox(height: 20),
//               //                 ElevatedButton(
//               //                   onPressed: () {
//               //                     _showAddItemPopup(context);
//               //                   },
//               //                   child: const Text('Add unit'),
//               //                 ),
//               //               ],
//               //             ),
//               //           );
//               //         }),
//               //       ),
//               //     );
//               //   },
//               //   child: const ListTile(
//               //     leading: Icon(Icons.balance_outlined),
//               //     title: Text('Unit'),
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAddItemPopup(BuildContext context) {
//     TextEditingController addItemController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add New unit'),
//           content: TextField(
//             controller: addItemController,
//             decoration: const InputDecoration(labelText: 'Type Unit'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 String newItem = addItemController.text;
//                 if (newItem.isNotEmpty) {
//                   setState(() {
//                     unit.add(newItem);
//                     Unitdropdownvalue =
//                         newItem; // Select the newly added item in dropdown
//                   });
//                   Navigator.pop(context); // Close the popup
//                 }
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
