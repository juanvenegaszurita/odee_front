import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';

import 'package:odee_front/src/models/models.dart';

class NotificationPushService {
  /* Singleton */
  static final NotificationPushService _notificationPushService =
      NotificationPushService._();
  factory NotificationPushService() {
    return _notificationPushService;
  }
  NotificationPushService._();

  Future<ResponseModel<List<NotificationPushModel>>> get() async {
    final resp = await http.get(Globals.getUri("/NotificationsPush"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload = decodeResp.payload
        .map((e) => NotificationPushModel.fromMap(e))
        .toList();
    final respFinal = ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
