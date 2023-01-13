import 'dart:convert';

import 'package:flutter/material.dart';

class RoutesMenuModel {
    RoutesMenuModel({
        required this.name,
        required this.icon,
        required this.page,
    });

    String name;
    IconData icon;
    Widget page;

    factory RoutesMenuModel.fromJson(String str) => RoutesMenuModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RoutesMenuModel.fromMap(Map<String, dynamic> json) => RoutesMenuModel(
        name: json["name"],
        icon: json["icon"],
        page: json["page"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "icon": icon,
        "page": page,
    };
}