import 'dart:convert';

import 'package:odee_front/src/cross/globals.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

abstract class UpdateS {
  Future<ResponseModel<Map>> update(url, Map<String, dynamic> body) async {
    final resp = await http.put(
      Globals.getUri("$url/${body['id']}"),
      headers: await Globals.getHeader(),
      body: json.encode(body),
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
