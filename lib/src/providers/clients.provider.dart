import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class ClientsProvider
    extends MaintainerProvider<ClientsService, ClientsModel> {
  @override
  late final ClientsService service = ClientsService();
  @override
  String url = '/Clients';

  final BusinessService serviceBusiness = BusinessService();
  List<BusinessModel> _listTF = [];
  List<BusinessModel> get listTF => _listTF;

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController businessController = TextEditingController();

  @override
  Future<void> constructorEnd() async {
    final ltf = await serviceBusiness.read();
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
      "rut": rutController.text,
      "address": addressController.text,
      "business_id": int.parse(businessController.text),
    };
    clearForm();
  }

  @override
  void setFormUpdate() {
    bodyUpdate = {
      "id": int.parse(idController.text),
      "name": nameController.text,
      "rut": rutController.text,
      "address": addressController.text,
      "business_id": int.parse(businessController.text),
    };
    clearForm();
  }

  @override
  void clearForm() {
    nameController.text = "";
    rutController.text = "";
    addressController.text = "";
    businessController.text = "";
    idController.text = "";
  }
}
