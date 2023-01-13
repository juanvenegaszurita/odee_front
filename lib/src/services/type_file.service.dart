import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import '../abstract_class/abstract_class.dart';

class TypeFileService extends MaintainerService {
  /* Singleton */
  static final TypeFileService _typeFileService = TypeFileService._();
  factory TypeFileService() {
    return _typeFileService;
  }
  TypeFileService._();

  @override
  Future<ResponseModel<List<TypeFileModel>>> read() async {
    final resp = await http.get(Globals.getUri("/TypeFile"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => TypeFileModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
