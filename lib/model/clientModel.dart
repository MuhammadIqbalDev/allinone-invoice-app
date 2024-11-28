// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClientModel {
  final int client_id;
  final String clientName;
  final String clientAddress;
  final String clientPhone;
  final String clientEmail;

  ClientModel(
    this.client_id,
    this.clientName,
    this.clientAddress,
    this.clientPhone,
    this.clientEmail,
  );

  ClientModel copyWith({
    int? client_id,
    String? clientName,
    String? clientAddress,
    String? clientPhone,
    String? clientEmail,
  }) {
    return ClientModel(
      client_id ?? this.client_id,
      clientName ?? this.clientName,
      clientAddress ?? this.clientAddress,
      clientPhone ?? this.clientPhone,
      clientEmail ?? this.clientEmail,
    );
  }

  static Map<String, dynamic> toMap({ClientModel? c}) {
    if (c != null) {
      return <String, dynamic>{
        'client_id':c.client_id,
        'clientName': c.clientName,
        'clientAddress': c.clientAddress,
        'clientPhone': c.clientPhone,
        'clientEmail': c.clientEmail,
      };
    } else {
      return {};
    }
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      map['client_id'] as int,
      map['clientName'] as String,
      map['clientAddress'] as String,
      map['clientPhone'] as String,
      map['clientEmail'] as String,
    );
  }

  static Map<String, List<dynamic>> convertListToMap(
      List<ClientModel> ClientList) {
    List mappedData = [];
    for (ClientModel c in ClientList) {
      mappedData.add(ClientModel.toMap(c: c));
    }
    return {'clients': mappedData};
  }
  String toJson() => json.encode(toMap());
  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'ClientModel(clientName: $clientName, clientAddress: $clientAddress, clientPhone: $clientPhone, clientEmail: $clientEmail)';
  }

  @override
  bool operator ==(covariant ClientModel other) {
    if (identical(this, other)) return true;

    return other.clientName == clientName &&
        other.clientAddress == clientAddress &&
        other.clientPhone == clientPhone &&
        other.clientEmail == clientEmail;
  }

  @override
  int get hashCode {
    return clientName.hashCode ^
        clientAddress.hashCode ^
        clientPhone.hashCode ^
        clientEmail.hashCode;
  }
}
