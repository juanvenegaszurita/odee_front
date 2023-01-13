import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import '../abstract_class/abstract_class.dart';

class ProdServService extends MaintainerService {
  /* Singleton */
  static final ProdServService _prodServService = ProdServService._();
  factory ProdServService() {
    return _prodServService;
  }
  ProdServService._();

  @override
  Future<ResponseModel<List<ProdServModel>>> read() async {
    final resp = await http.get(Globals.getUri("/ProdServ"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => ProdServModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
