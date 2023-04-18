import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class TypeFileProvider
    extends MaintainerProvider<TypeFileService, TypeFileModel> {
  @override
  late final TypeFileService service = TypeFileService();
  @override
  String url = '/TypeFile';

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mimeController = TextEditingController();
  TextEditingController extensionController = TextEditingController();

  @override
  void setFormCreate() {
    body = {
      "name": nameController.text,
      "mime": mimeController.text,
      "extension": extensionController.text,
    };
    clearForm();
  }

  @override
  void setFormUpdate() {
    bodyUpdate = {
      "id": int.parse(idController.text),
      "name": nameController.text,
      "mime": mimeController.text,
      "extension": extensionController.text,
    };
    clearForm();
  }

  @override
  void clearForm() {
    nameController.text = "";
    mimeController.text = "";
    extensionController.text = "";
    idController.text = "";
  }
}
