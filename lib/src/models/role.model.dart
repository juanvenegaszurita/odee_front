import 'dart:convert';

import 'package:odee_front/src/models/models.dart';

class RoleModel implements BaseModel {
  RoleModel({
    required this.id,
    required this.description,
  });

  @override
  int id;
  String description;

  factory RoleModel.fromJson(String str) => RoleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoleModel.fromMap(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        description: json["description"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
      };
}
