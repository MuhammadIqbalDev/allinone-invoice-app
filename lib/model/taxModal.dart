import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddTax {
  final int tax_id;
  final String taxLabel;
  final String taxType;
  final double taxPercentage;
  AddTax(
    this.tax_id,
    this.taxLabel,
    this.taxType,
    this.taxPercentage,
  );

  AddTax copyWith({
    int? tax_id,
    String? taxLabel,
    String? taxType,
    double? taxPercentage,
  }) {
    return AddTax(
      tax_id ??this.tax_id,
      taxLabel ?? this.taxLabel,
      taxType ?? this.taxType,
      taxPercentage ?? this.taxPercentage,
    );
  }

  factory AddTax.fromMap(Map<String, dynamic> map) {
   
    return AddTax(
    int.parse(map['tax_id'].toString()),
     map['taxLabel'].toString(),
     map['taxType'].toString(),
    double.parse(map['taxPercentage'].toString()),
     
    );
  }



  static Map<String, dynamic> toMap({AddTax? i}) {
    if (i != null) {
      return <String, dynamic>{
        'tax_id': i.tax_id,
        'taxLabel': i.taxLabel,
        'taxType': i.taxType,
        'taxPercentage': i.taxPercentage
      };
    } else {
      return {};
    }
  }

  static Map<String, List<dynamic>> convertListToMap(List<AddTax> TaxList) {
    List mappedData = [];

    for (AddTax i in TaxList) {
      mappedData.add(AddTax.toMap(i: i));
    }

    return {'taxes': mappedData};
  }

  // factory AddTax.fromMap(Map<String, dynamic> map) {
  //   return AddTax(
  //     taxType: map['taxType'] as String,
  //     taxPercentage: map['taxPercentage'] as String
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory AddTax.fromJson(String source) =>
      AddTax.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddTax(taxLabel: $taxLabel, taxType: $taxType, taxPercentage: $taxPercentage)';

  @override
  bool operator ==(covariant AddTax other) {
    if (identical(this, other)) return true;

    return other.taxLabel == taxLabel &&
        other.taxType == taxType &&
        other.taxPercentage == taxPercentage;
  }

  @override
  int get hashCode =>
      taxLabel.hashCode ^ taxType.hashCode ^ taxPercentage.hashCode;
}
