import 'dart:convert';

import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/models/quotation_model.dart';

class ClientsModel implements BaseModel {
  ClientsModel({
    required this.id,
    required this.name,
    required this.rut,
    required this.address,
    required this.business_id,
    required this.business,
    required this.quotation,
  });

  @override
  int id;
  String name;
  String rut;
  String address;
  int business_id;
  BusinessModel? business;
  List<QuotationModel>? quotation;

  factory ClientsModel.fromJson(String str) =>
      ClientsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientsModel.fromMap(Map<String, dynamic> jsonD) => ClientsModel(
        id: jsonD["id"],
        name: jsonD["name"],
        rut: jsonD["rut"],
        address: jsonD["address"],
        business_id: jsonD["business_id"],
        business: jsonD["business"] != null ? BusinessModel.fromMap(jsonD["business"]) : null,
        quotation: jsonD["quotation"] != null ? (jsonD["quotation"] as List<dynamic>).map((e) => QuotationModel.fromMap(e)).toList() : [],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "rut": rut,
        "address": address,
        "business_id": business_id,
        "business": business != null ? business?.toMap() : {},
        "quotation": quotation != null? quotation?.map((e) => e.toMap()) : [],
      };
  @override
  String toString() {
    return "$id$name$rut$address$business_id";
  }
}
