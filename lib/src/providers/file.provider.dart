import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class FileProvider
    extends MaintainerProvider<FileService, FileModel> {
  @override
  late final FileService service = FileService();
  @override
  String url = '/File';

  final TypeFileService serviceTypeFile = TypeFileService();
  List<TypeFileModel> _listTF = [];
  List<TypeFileModel> get listTF => _listTF;

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController typeFileController = TextEditingController();

  @override
  Future<void> constructorEnd() async {
    final ltf = await serviceTypeFile.read();
    if ([200, 201].contains(ltf.code)) {
      _listTF.clear();
      _listTF = ltf.payload;
    } else {
      NotificationsService.error(ltf.payload.toString());
    }
    notifyListeners();
  }

  @override
  void setFormCreate() {
    body = {
      "url": urlController.text,
      "typeFile_id": int.parse(typeFileController.text),
    };
    clearForm();
  }

  @override
  void setFormUpdate() {
    bodyUpdate = {
      "id": int.parse(idController.text),
      "url": urlController.text,
      "typeFile_id": int.parse(typeFileController.text),
    };
    clearForm();
  }

  @override
  void clearForm() {
    urlController.text = "";
    typeFileController.text = "";
    idController.text = "";
  }
}
