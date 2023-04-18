import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import '../abstract_class/abstract_class.dart';

class BusinessService extends MaintainerService {
  /* Singleton */
  static final BusinessService _businessService = BusinessService._();
  factory BusinessService() {
    return _businessService;
  }
  BusinessService._();

  @override
  Future<ResponseModel<List<BusinessModel>>> read() async {
    final resp = await http.get(Globals.getUri("/business"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => BusinessModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }

  Future<ResponseModel<List<BusinessModel>>> readAll() async {
    final resp = await http.get(Globals.getUri("/Business/get/All"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => BusinessModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
