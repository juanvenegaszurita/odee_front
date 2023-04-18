import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import '../abstract_class/abstract_class.dart';

class RoleService extends MaintainerService {
  /* Singleton */
  static final RoleService _roleService = RoleService._();
  factory RoleService() {
    return _roleService;
  }
  RoleService._();

  @override
  Future<ResponseModel<List<RoleModel>>> read() async {
    final resp = await http.get(Globals.getUri("/Role"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => RoleModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
