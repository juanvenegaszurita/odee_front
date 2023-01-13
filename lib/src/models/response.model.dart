import 'dart:convert';

class ResponseModel<T> {
    ResponseModel({
        required this.message,
        required this.payload,
    });

    String message;
    T payload;
    int code = 0;

    factory ResponseModel.fromJson(String str) => ResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResponseModel.fromMap(Map<String, dynamic> json) => ResponseModel(
        message: json["message"],
        payload: json["payload"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "payload": payload,
    };
}