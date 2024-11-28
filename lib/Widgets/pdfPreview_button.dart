// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../model/addnewInvoice.dart';
import '../pdf_preview_page.dart';

class PDFPreviewButton extends StatefulWidget {
  const PDFPreviewButton({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);
  final String name;
  final String email;

  @override
  State<PDFPreviewButton> createState() => _PDFPreviewButtonState();
}

class _PDFPreviewButtonState extends State<PDFPreviewButton> {
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
  @override
  Widget build(BuildContext context) {


    return Container(
      child: InkWell(
        onTap: () {
          
        },
        child: const Row(
          children: [
            Icon(
              Icons.document_scanner_outlined,
              size: 30,
            ), // Replace 'some_icon' with the desired icon
            SizedBox(width: 10), // Adjust the spacing between the icon and text
            Text(
              "PDF Preview",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
