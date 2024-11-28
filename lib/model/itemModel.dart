import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddItem {
  final int selected_id;
  final int itemId;
  final String itemName;
  final String description;
  final double unitPrice;
  final String unit;
  final int quantity;
  final double total;
  final String category;
  final bool taxable;

  AddItem({
    required this.selected_id,
    required this.itemId,
    required this.itemName,
    required this.description,
    required this.unitPrice,
    required this.unit,
    required this.quantity,
    required this.total,
    required this.category,
    required this.taxable,
  });

  AddItem copyWith({
    int? selected_id,
    int? itemId,
    String? itemName,
    String? description,
    double? unitPrice,
    String? unit,
    int? quantity,
    double? total,
    String? category,
    bool? taxable,
  }) {
    return AddItem(
      selected_id: selected_id ?? this.selected_id,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      unitPrice: unitPrice ?? this.unitPrice,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      category: category ?? this.category,
      taxable: taxable ?? this.taxable,
    );
  }

  static Map<String, dynamic> toMap({AddItem? i}) {
    if (i != null) {
      return <String, dynamic>{
        'selected_id': i.selected_id,
        'itemId': i.itemId,
        'itemName': i.itemName,
        'description': i.description.isEmpty ? "null" : i.description,
        'unitPrice': i.unitPrice,
        'unit': i.unit,
        'quantity': i.quantity,
        'total': i.total,
        'category': i.category,
        'taxable': i.taxable,
      };
    } else {
      return {};
    }
  }

  static Map<String, List<dynamic>> convertListToMap(List<AddItem> ItemList) {
    List mappedData = [];

    for (AddItem i in ItemList) {
      mappedData.add(AddItem.toMap(i: i));
    }

    return {'items': mappedData};
  }

  factory AddItem.fromMap(Map<String, dynamic> map) {
    return AddItem(
      selected_id: map['selected_id'] as int,
      itemId: map['itemId'] as int,
      itemName: map['itemName'] as String,
      description: map['description'] as String,
      unitPrice: map['unitPrice'] as double,
      unit: map['unit'] as String,
      quantity: map['quantity'] as int,
      total: map['total'] as double,
      category: map['category'] as String,
      taxable: map['taxable'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddItem.fromJson(String source) =>
      AddItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddItem(selected_id: $selected_id, itemId: $itemId, itemName: $itemName, description: $description, unitPrice: $unitPrice, unit: $unit, quantity: $quantity, total: $total, category: $category, taxable: $taxable)';
  }

  @override
  bool operator ==(covariant AddItem other) {
    if (identical(this, other)) return true;

    return other.selected_id == selected_id &&
        other.itemId == itemId &&
        other.itemName == itemName &&
        other.description == description &&
        other.unitPrice == unitPrice &&
        other.unit == unit &&
        other.quantity == quantity &&
        other.total == total &&
        other.category == category &&
        other.taxable == taxable;
  }

  @override
  int get hashCode {
    return selected_id.hashCode ^
        itemId.hashCode ^
        itemName.hashCode ^
        description.hashCode ^
        unitPrice.hashCode ^
        unit.hashCode ^
        quantity.hashCode ^
        total.hashCode ^
        category.hashCode ^
        taxable.hashCode;
  }
}
