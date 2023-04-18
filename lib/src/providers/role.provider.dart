import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class RoleProvider
    extends MaintainerProvider<RoleService, RoleModel> {
  @override
  late final RoleService service = RoleService();
  @override
  String url = '/Role';

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void setFormCreate() {
    body = {
      "description": descriptionController.text,
    };
    clearForm();
  }

  @override
  void setFormUpdate() {
    bodyUpdate = {
      "id": int.parse(idController.text),
      "description": descriptionController.text,
    };
    clearForm();
  }

  @override
  void clearForm() {
    descriptionController.text = "";
    idController.text = "";
  }
}
