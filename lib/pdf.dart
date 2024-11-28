// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:io';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Example',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Invoice'),
//         ),
//         body: const PdfGenerator(),
//       ),
//     );
//   }
// }

// class PdfGenerator extends StatefulWidget {
//   const PdfGenerator({super.key});

//   @override
//   _PdfGeneratorState createState() => _PdfGeneratorState();
// }

// class _PdfGeneratorState extends State<PdfGenerator> {
//   Future<void> makePdf() async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(build: (pw.Context context) {
//         return pw.Column(children: [
//           pw.Row(children: [
//             pw.Text('Date Time', style: const pw.TextStyle(fontSize: 20)),
//           ]),
//         ]);
//       }),
//     );
//      final directory = await getExternalStorageDirectory();
//   final filePath = path.join(directory!.path, 'example.pdf');
//   final file = File(filePath);

//   await file.writeAsBytes(await pdf.save());
//   //    final directory = await getExternalStorageDirectory();
//   //   final file = File('example.pdf');
//   // await file.writeAsBytes(await pdf.save());

//     // final output = await getTemporaryDirectory();
//     // final file = File("${output.path}/example.pdf");
//     // await file.writeAsBytes(await pdf.save());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           makePdf();
//         },
//         child: const Text('Generate PDF'),
//       ),
//     );
//   }
// }
