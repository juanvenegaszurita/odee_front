import 'dart:convert';
import 'package:odee_front/src/models/models.dart';

class ProdServModel implements BaseModel {
  ProdServModel({
    required this.id,
    required this.detail,
    required this.price,
    required this.type,
  });

  @override
  int id;
  String detail;
  int price;
  String type;

  factory ProdServModel.fromJson(String str) =>
      ProdServModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProdServModel.fromMap(Map<String, dynamic> json) => ProdServModel(
        id: json["id"],
        detail: json["detail"],
        price: json["price"],
        type: json["type"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "detail": detail,
        "price": price,
        "type": type,
      };
}
