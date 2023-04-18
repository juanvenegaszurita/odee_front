import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class BusinessProvider
    extends MaintainerProvider<BusinessService, BusinessModel> {
  @override
  late final BusinessService service = BusinessService();
  @override
  String url = '/Business';

  final UserService userService = UserService();
  List<UserModel> _listTF = [];
  List<UserModel> get listTF => _listTF;

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController rutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userController = TextEditingController();

  @override
  Future<void> constructorEnd() async {
    final ltf = await userService.read();
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
      "name": nameController.text,
      "business_name": businessNameController.text,
      "rut": rutController.text,
      "address": addressController.text,
      "users_id": int.parse(userController.text),
    };
    clearForm();
  }

  @override
  void setFormUpdate() {
    bodyUpdate = {
      "id": int.parse(idController.text),
      "name": nameController.text,
      "business_name": businessNameController.text,
      "rut": rutController.text,
      "address": addressController.text,
      "users_id": int.parse(userController.text),
    };
    clearForm();
  }

  @override
  void clearForm() {
    nameController.text = "";
    businessNameController.text = "";
    rutController.text = "";
    addressController.text = "";
    userController.text = "";
    idController.text = "";
  }
}
