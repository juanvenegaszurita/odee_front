import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
import 'package:odee_front/src/models/models.dart';
import '../abstract_class/abstract_class.dart';

class FileService extends MaintainerService {
  /* Singleton */
  static final FileService _fileService = FileService._();
  factory FileService() {
    return _fileService;
  }
  FileService._();

  @override
  Future<ResponseModel<List<FileModel>>> read() async {
    final resp = await http.get(Globals.getUri("/File"));
    final decodeResp = ResponseModel<List<dynamic>>.fromJson((resp.body));
    final payload =
        decodeResp.payload.map((e) => FileModel.fromMap(e)).toList();
    final respFinal =
        ResponseModel(message: decodeResp.message, payload: payload);
    respFinal.code = resp.statusCode;
    return respFinal;
  }
}
