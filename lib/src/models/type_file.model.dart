import 'dart:convert';

import 'package:odee_front/src/models/models.dart';

class TypeFileModel implements BaseModel {
  TypeFileModel({
    required this.id,
    required this.name,
    required this.mime,
  });

  @override
  int id;
  String name;
  String mime;

  factory TypeFileModel.fromJson(String str) => TypeFileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeFileModel.fromMap(Map<String, dynamic> json) => TypeFileModel(
        id: json["id"],
        name: json["name"],
        mime: json["mime"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "mime": mime,
      };
}
