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
}
