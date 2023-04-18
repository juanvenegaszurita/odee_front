import 'dart:convert';

import 'package:odee_front/src/models/models.dart';

class TypeFileModel implements BaseModel {
  TypeFileModel({
    required this.id,
    required this.name,
    required this.mime,
    required this.extension,
  });

  @override
  int id;
  String name;
  String mime;
  String extension;

  factory TypeFileModel.fromJson(String str) => TypeFileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeFileModel.fromMap(Map<String, dynamic> json) => TypeFileModel(
        id: json["id"],
        name: json["name"],
        mime: json["mime"],
        extension: json["extension"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "mime": mime,
        "extension": extension,
      };
}
