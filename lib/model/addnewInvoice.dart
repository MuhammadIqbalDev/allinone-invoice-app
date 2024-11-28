// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:invoice_app/model/itemModel.dart';

import 'businessInfo.dart';
import 'clientModel.dart';

class InvoiceModel {
  final int invoice_id;
  final Business_Info business;
  final ClientModel Client;
  final List<AddItem> items;
  final double subtotal;
  final double total;
  final double tax;
  final double discount;
  final DateTime date;
  final DateTime issuedate;
  final DateTime 
  duedate;
  InvoiceModel(
    this.invoice_id,
    this.business,
    this.Client,
    this.items,
    this.subtotal,
    this.total,
    this.tax,
    this.discount,
    this.date,
    this.issuedate,
    this.duedate,
  );

  InvoiceModel copyWith({
    int? invoice_id,
    Business_Info? business,
    ClientModel? Client,
    List<AddItem>? items,
    double? subtotal,
    double? total,
    double? tax,
    double? discount,
    DateTime? date,
    DateTime? issuedate,
    DateTime? duedate,
  }) {
    return InvoiceModel(
      invoice_id ?? this.invoice_id,
      business ?? this.business,
      Client ?? this.Client,
      items ?? this.items,
      subtotal ?? this.subtotal,
      total ?? this.total,
      tax ?? this.tax,
      discount ?? this.discount,
      date ?? this.date,
      issuedate ?? this.issuedate,
      duedate ?? this.duedate,
    );
  }

  static Map<String, dynamic> toMap({InvoiceModel? i}) {
    log(i.toString());
    return i != null
        ? <String, dynamic>{
            'invoice_id': i.invoice_id,
            'business': Business_Info.toMap(b: i.business),
            'Client': ClientModel.toMap(c: i.Client),
            'items': AddItem.convertListToMap(i.items),
            'subtotal': i.subtotal,
            'total': i.total,
            'tax': i.tax,
            'discount': i.discount,
            'date': i.date.millisecondsSinceEpoch,
          }
        : {'invoices': []};
  }

  static Map<String, List<dynamic>> convertListToMap(
      List<InvoiceModel> invoiceList) {
    List<Map<String, dynamic>> mappedData = [];

    for (InvoiceModel v in invoiceList) {
      mappedData.add(InvoiceModel.toMap(
          i: v)); // Call the toMap() method on specific InvoiceModel instance
    }

    return {'invoices': mappedData};
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      map['invoice_id'] as int,
      Business_Info.fromMap(map['business'] as Map<String,dynamic>),
      ClientModel.fromMap(map['Client'] as Map<String,dynamic>),
      List<AddItem>.from((map['items'] as List<int>).map<AddItem>((x) => AddItem.fromMap(x as Map<String,dynamic>),),),
      map['subtotal'] as double,
      map['total'] as double,
      map['tax'] as double,
      map['discount'] as double,
      DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      DateTime.fromMillisecondsSinceEpoch(map['issuedate'] as int),
      DateTime.fromMillisecondsSinceEpoch(map['duedate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(invoice_id: $invoice_id, business: $business, Client: $Client, items: $items, subtotal: $subtotal, total: $total, tax: $tax, discount: $discount, date: $date, issuedate: $issuedate, duedate: $duedate)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.invoice_id == invoice_id &&
      other.business == business &&
      other.Client == Client &&
      listEquals(other.items, items) &&
      other.subtotal == subtotal &&
      other.total == total &&
      other.tax == tax &&
      other.discount == discount &&
      other.date == date &&
      other.issuedate == issuedate &&
      other.duedate == duedate;
  }

  @override
  int get hashCode {
    return invoice_id.hashCode ^
      business.hashCode ^
      Client.hashCode ^
      items.hashCode ^
      subtotal.hashCode ^
      total.hashCode ^
      tax.hashCode ^
      discount.hashCode ^
      date.hashCode ^
      issuedate.hashCode ^
      duedate.hashCode;
  }

  
}
