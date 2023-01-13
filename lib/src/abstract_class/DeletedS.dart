import 'dart:convert';
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:http/http.dart' as http;

abstract class DeletedS {
  Future<ResponseModel<Map>> deleted(String url, String id) async {
    final resp = await http.delete(
      Globals.getUri("$url/$id"),
      headers: await Globals.getHeader(),
    );

    final Map<String, dynamic> decodeResp = jsonDecode(resp.body);
    final respFinal = ResponseModel(
      message: decodeResp['message'],
      payload: {},
    );
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
