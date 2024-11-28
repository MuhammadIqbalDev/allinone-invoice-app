import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:invoice_app/business_info.dart';

class Business_Info {
  final int business_id;
  final String name;
  final String address;
  final dynamic phone;
  final String? image;
  final String email;
  Business_Info( 
    this.business_id,
     this.name,
    this.address,
    this.phone,
    this.image,
    this.email,
  );

  Business_Info copyWith({
    int? business_id,
    String? name,
    String? address,
    dynamic phone,
    String? image,
    String? email,
  }) {
    return Business_Info(
     business_id ?? this.business_id,
      name ?? this.name,
     address ?? this.address,
     phone is int ? phone : int.tryParse(phone),
    image ?? this.image,
      email ?? this.email,
    );
  }

  static Map<String, dynamic> toMap({Business_Info? b}) {
    if (b != null) {
      return <String, dynamic>{
        'business_id': b.business_id,
        'name': b.name,
        'address': b.address,
        'phone':b.phone,
        'image': b.image,
        'email': b.email,
      };
    } else {
      return {};
    }
  }

  static Map<String, List<dynamic>> convertListToMap(
      List<Business_Info> businessList) {
    List mappedData = [];

    for (Business_Info b in businessList) {
      mappedData.add(Business_Info.toMap(b: b));
    }

    return {'business': mappedData};
  }

  factory Business_Info.fromMap(Map<String, dynamic> map) {
    return Business_Info(
       map['business_id'] as int,
      map['name'] as String,
       map['address'] as String,
       map['phone'] as int,
      map['image'] != null ? map['image'] as String : null,
      map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Business_Info.fromJson(String source) =>
      Business_Info.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Business_Info(name: $name, address: $address, image: $image, email: $email)';
  }

  @override
  bool operator ==(covariant Business_Info other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.image == image &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^ address.hashCode ^ image.hashCode ^ email.hashCode;
  }
}
