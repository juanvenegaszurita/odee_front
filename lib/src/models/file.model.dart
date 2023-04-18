import 'dart:convert';

import 'package:odee_front/src/models/models.dart';

class FileModel implements BaseModel {
    FileModel({
        required this.id,
        required this.url,
        required this.typeFile_id,
        required this.typeFile,
    });

    @override
    int id;
    String url;
    int typeFile_id;
    TypeFileModel typeFile;

    factory FileModel.fromJson(String str) => FileModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FileModel.fromMap(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        url: json["url"],
        typeFile_id: json["typeFile_id"],
        typeFile: TypeFileModel.fromMap(json["typeFile"]),
    );

    @override
    Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "typeFile_id": typeFile_id,
        "typeFile": typeFile.toMap(),
    };
}
