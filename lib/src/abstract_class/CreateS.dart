import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';

abstract class CreateS {
  Future<ResponseModel> create(url, body) async {
    final resp = await http.post(
      Globals.getUri(url),
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
