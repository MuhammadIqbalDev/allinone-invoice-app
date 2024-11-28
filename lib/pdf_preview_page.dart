import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../services/pdf_service.dart';
import 'package:printing/printing.dart';

import 'model/addnewInvoice.dart';

class PdfPreviewPage extends StatelessWidget {
  // final TextEditingController _textFieldNameController =
  //     TextEditingController();
  
  PdfPreviewPage({required this.invoice});

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'PDF Preview',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: PdfPreview(
        build: (context) {
          return PdfService(
            invoice: invoice,
          )
              .makeInvoicePdf([]);
        },
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: invoice.Client.clientName,
      ),
    );
  }
}
