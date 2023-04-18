import 'dart:convert';
import 'package:odee_front/src/models/models.dart';

class UserModel implements BaseModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.roles_id,
    required this.roles,
  });

  @override
  int id;
  String name;
  String email;
  String? UID;
  DateTime createdAt;
  int roles_id;
  RoleModel? roles;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) {
    final u = UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      createdAt: DateTime.parse(json["createdAt"]),
      roles_id: json["roles_id"],
      roles: json["roles"] != null ? RoleModel.fromMap(json["roles"]) : null,
    );
    u.UID = json["UID"] ?? '';
    return u;
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "UID": UID,
        "createdAt": createdAt.toIso8601String(),
        "roles_id": roles_id,
        "roles": roles != null? roles?.toMap() : {},
      };
  @override
  String toString() {
    return "$id$name$email${createdAt.toIso8601String()}";
  }
}
