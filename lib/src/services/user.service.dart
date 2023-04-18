import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import '../abstract_class/abstract_class.dart';

class UserService extends MaintainerService {
  /* Singleton */
  static final UserService _userService = UserService._();
  factory UserService() {
    return _userService;
  }
  UserService._();

  @override
  Future<ResponseModel<List<UserModel>>> read() async {
    final resp = await http.get(Globals.getUri("/User"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => UserModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload,);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
