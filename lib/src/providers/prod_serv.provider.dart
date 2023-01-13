import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';

import 'providers.dart';

class ProdServProvider
    extends MaintainerProvider<ProdServService, ProdServModel> {
  @override
  late final ProdServService service = ProdServService();
  @override
  String url = '/ProdServ';

  //form
  TextEditingController idController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
}
