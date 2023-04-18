import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class UserProvider
    extends MaintainerProvider<UserService, UserModel> {
  @override
  late final UserService service = UserService();
  @override
  String url = '/User';

  final RoleService serviceRole = RoleService();
  List<RoleModel> _listRole = [];
  List<RoleModel> get listRole => _listRole;

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  Future<void> constructorEnd() async {
    final lrole = await serviceRole.read();
    if ([200, 201].contains(lrole.code)) {
      _listRole.clear();
      _listRole = lrole.payload;
    } else {
      NotificationsService.error(lrole.payload.toString());
    }
    notifyListeners();
  }

  @override
  void setFormCreate() {
    body = {
      "name": nameController.text,
      "email": emailController.text,
      "roles_id": int.parse(roleController.text),
    };
    clearForm();
  }

  @override
  void setFormUpdate() {
    bodyUpdate = {
      "id": int.parse(idController.text),
      "name": nameController.text,
      "email": emailController.text,
      "roles_id": int.parse(roleController.text),
    };
    clearForm();
  }

  @override
  void clearForm() {
    idController.text = "";
    nameController.text = "";
    emailController.text = "";
    roleController.text = "";
  }
}
