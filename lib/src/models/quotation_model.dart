import 'dart:convert';

import 'package:odee_front/src/models/models.dart';

class QuotationModel implements BaseModel {
  QuotationModel({
    required this.id,
    required this.title,
    required this.detail,
    required this.dateQuote,
    required this.clients_id,
    required this.clients,
    required this.file_id,
    required this.file,
  });

  @override
  int id;
  String title;
  String detail;
  String dateQuote;
  int clients_id;
  ClientsModel? clients;
  int file_id;
  FileModel? file;

  factory QuotationModel.fromJson(String str) =>
      QuotationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuotationModel.fromMap(Map<String, dynamic> json) => QuotationModel(
        id: json["id"],
        title: json["title"],
        detail: json["detail"],
        dateQuote: json["dateQuote"],
        clients_id: json["clients_id"],
        clients: json["clients"] != null ? ClientsModel.fromMap(json["clients"]) : null,
        file_id: json["file_id"],
        file: json["file"] != null ? FileModel.fromMap(json["file"]) : null,
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "detail": detail,
        "dateQuote": dateQuote,
        "clients_id": clients_id,
        "clients": clients != null? clients?.toMap() : {},
        "file_id": file_id,
        "file": file != null? file?.toMap() : {},
      };
}
