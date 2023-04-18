import 'dart:convert';

import 'package:odee_front/src/models/models.dart';

class BusinessModel implements BaseModel {
    BusinessModel({
        required this.id,
        required this.name,
        required this.business_name,
        required this.rut,
        required this.users_id,
        required this.address,
        required this.users,
        required this.clients,
    });

    @override
    int id;
    String name;
    String business_name;
    String rut;
    int users_id;
    String address;
    UserModel? users;
    List<ClientsModel>? clients;

    factory BusinessModel.fromJson(String str) => BusinessModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BusinessModel.fromMap(Map<String, dynamic> jsonD) => BusinessModel(
        id: jsonD["id"],
        name: jsonD["name"],
        business_name: jsonD["business_name"],
        rut: jsonD["rut"],
        address: jsonD["address"],
        users_id: jsonD["users_id"],
        users: jsonD["users"] != null ? UserModel.fromMap(jsonD["users"]) : null,
        clients: jsonD["clients"] != null ? (jsonD["clients"] as List<dynamic>).map((e) => ClientsModel.fromMap(e)).toList() : [],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "business_name": business_name,
        "rut": rut,
        "address": address,
        "users_id": users_id,
        "users": users != null? users?.toMap() : {},
        "clients": clients != null? clients?.map((e) => e.toMap()) : [],
    };
    @override
  String toString() {
    return "$id$name$business_name$rut$address$users_id${users.toString()}${clients!.map((e) => e.toString()).join('')}";
  }
}