import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;

import '../model/addnewInvoice.dart';
import '../newClient.dart';

class PdfService {
  PdfService({required this.invoice});

  final InvoiceModel invoice;

  Future<Uint8List> makeInvoicePdf(List<Map<String, dynamic>> allItems) async {
    final pddf = pdf.Document();
    //    DateTime issuedate = DateTime.now();
    // DateTime duedate = DateTime.now();
    String issueformattedDate =
        DateFormat('dd/MM/yyyy').format(invoice.issuedate);
    String dueformattedDate = DateFormat('dd/MM/yyyy').format(invoice.duedate);

    pddf.addPage(pdf.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          pdf.Column(
            crossAxisAlignment: pdf.CrossAxisAlignment.start,
            mainAxisSize: pdf.MainAxisSize.max,
            children: [
              pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                  children: [
                    pdf.Column(
                        crossAxisAlignment: pdf.CrossAxisAlignment.start,
                        children: [
                          pdf.Text('BUSINESS:',
                              style: const pdf.TextStyle(
                                  fontSize: 12, color: PdfColors.grey700)),
                          pdf.Text('Name: ${invoice.business.name}',
                              style: const pdf.TextStyle(fontSize: 12)),
                          invoice.business.email.isNotEmpty? pdf.Text('Email: ${invoice.business.email}',
                              style: const pdf.TextStyle(fontSize: 12)):pdf.Text(''),
                          pdf.SizedBox(height: 20),
                          pdf.Text('BILL TO:',
                              style: const pdf.TextStyle(
                                  fontSize: 12, color: PdfColors.grey700)),
                          pdf.Text('Name: ${invoice.Client.clientName}',
                              style: const pdf.TextStyle(fontSize: 12)),
                         invoice.Client.clientEmail.isNotEmpty? pdf.Text('Email: ${invoice.Client.clientEmail}',
                          style: const pdf.TextStyle(fontSize: 12)):pdf.Text(''),
                        ]),
                    pdf.Column(
                        crossAxisAlignment: pdf.CrossAxisAlignment.end,
                        children: [
                          pdf.Text("Invoice",
                              style: const pdf.TextStyle(fontSize: 26)),
                          pdf.Text(
                              'Number: INV#${invoice.invoice_id < 10 ? '00${invoice.invoice_id}' : invoice.invoice_id < 100 ? '0${invoice.invoice_id}' : invoice.invoice_id}',
                              style: const pdf.TextStyle(fontSize: 12)),
                          pdf.Text('Issue Date: $issueformattedDate'),
                          pdf.Text('Due Date: $dueformattedDate'),
                        ]),
                  ]),

              pdf.SizedBox(height: 30),
              pdf.Table(
                border: pdf.TableBorder.symmetric(),
                children: [
                  pdf.TableRow(
                    children: [
                      pdf.SizedBox(
                        width: 25,
                        child: paddedText('No.'),
                      ),
                      pdf.SizedBox(
                        width: 25,
                        child: paddedText('Item Name'),
                      ),
                      pdf.SizedBox(
                        width: 25,
                        child: paddedText('Quantity'),
                      ),
                      pdf.SizedBox(
                        width: 25,
                        child: paddedText('Price'),
                      ),
                      pdf.SizedBox(
                        width: 25,
                        child: paddedText('Item Total'),
                      ),
                    ],
                  ),
                  // ... Add your header row
                ],
              ),
              pdf.Divider(
                thickness: 2,
                color: PdfColors.black,
              ),
              pdf.ListView.builder(
                itemBuilder: ((context, index) {
                  return pdf.Table(
                    border: pdf.TableBorder.symmetric(
                        // outside: const pdf.BorderSide(color: PdfColors.black),
                        // inside: const pdf.BorderSide(color: PdfColors.black),
                        ),
                    children: [
                      pdf.TableRow(
                        children: [
                          pdf.SizedBox(
                            width: 25,
                            child: paddedText('${index + 1}'.toString()),
                          ),
                          pdf.SizedBox(
                            width: 25,
                            child: paddedText(invoice.items[index].itemName),
                          ),
                          pdf.SizedBox(
                            width: 25,
                            child: paddedText(
                                invoice.items[index].quantity.toString()),
                          ),
                          pdf.SizedBox(
                            width: 25,
                            child: paddedText(
                                invoice.items[index].unitPrice.toString()),
                          ),
                          pdf.SizedBox(
                            width: 25,
                            child: paddedText(
                                '$currency ${invoice.items[index].quantity * invoice.items[index].unitPrice}'),
                          ),
                        ],
                      ),
                      // ... Add more rows for each item
                    ],
                  );
                }),
                itemCount: invoice.items.length,
              ),
              pdf.Divider(
                thickness: 2,
                color: PdfColors.black,
              ),
              pdf.Row(
                mainAxisAlignment: pdf.MainAxisAlignment.end,
                children: [
                  pdf.SizedBox(
                    child: pdf.Table(
                      border: pdf.TableBorder.symmetric(
                          outside: pdf.BorderSide.none),
                      children: [
                        pdf.TableRow(children: [
                          pdf.Padding(padding: const pdf.EdgeInsets.all(15)),
                          pdf.Text('Subtotal : '),
                          // pdf.SizedBox(width: 10),
                          pdf.Text('$currency ''${invoice.subtotal.toString()}'),
                        ]),
                        pdf.TableRow(children: [
                          pdf.Padding(padding: const pdf.EdgeInsets.all(15)),
                          pdf.Text('Discount : '),
                          // pdf.SizedBox(width: 10),
                          pdf.Text('$currency ''${invoice.discount.toString()}'),
                        ]),
                        pdf.TableRow(children: [
                          pdf.Padding(padding: const pdf.EdgeInsets.all(15)),
                          pdf.Text('Tax : '),
                          // pdf.SizedBox(width: 10),
                          pdf.Text('$currency ''${invoice.tax.toString()}'),
                        ]),
                        pdf.TableRow(children: [
                          pdf.Padding(padding: const pdf.EdgeInsets.all(15)),
                          pdf.Text('Total : '),
                          // pdf.SizedBox(width: 10),
                          pdf.Text('$currency ''${invoice.total.toString()}'),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              // ... Add the remaining content
            ],
          ),
        ];
      },
    ));
    return pddf.save();
  }

  pdf.Widget paddedText(
    final String text, {
    final PdfColor color = PdfColors.black,
  }) =>
      pdf.Padding(
        padding: const pdf.EdgeInsets.all(5),
        child: pdf.Text(
          text,
          style: pdf.TextStyle(
            fontSize: 12,
            fontWeight: pdf.FontWeight.normal,
            color: color,
          ),
        ),
      );
}
