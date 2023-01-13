import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/services/services.dart';
import 'package:odee_front/src/abstract_class/abstract_class.dart';

enum TypeForm {
  EDIT,
  CREATE,
}

class MaintainerProvider<S extends MaintainerService, M extends BaseModel> with ChangeNotifier {
  late final S service;
  late String url;

  TextEditingController filterController = TextEditingController();
  TypeForm? typeForm;
  bool _loadRead = false;
  List<M> _list = [];
  List<M> get list => _list;
  List<M> _listFilter = [];
  List<M> get listFilter => _listFilter;
  bool get loadRead => _loadRead;
  set loadRead(bool loadRead) => _loadRead = loadRead;
  Map<String, dynamic> body = {};

  MaintainerProvider() {
    read();
  }

  Future<void> _read() async {
    final listce = await service.read();
    if ([200, 201].contains(listce.code)) {
      _list.clear();
      _list = listce.payload;
      _listFilter.clear();
      _listFilter = listce.payload;
    } else {
      NotificationsService.error(listce.payload.toString());
    }
  }

  Future<void> read() async {
    _loadRead = true;
    notifyListeners();
    await _read();
    _loadRead = false;
    notifyListeners();
  }

  bool _loadCreate = false;
  bool get loadCreate => _loadCreate;
  set loadCreate(bool loadCreate) => _loadCreate = loadCreate;

  Future<void> create() async {
    _loadCreate = true;
    notifyListeners();
    final listce = await service.create(url, body);
    if ([200, 201].contains(listce.code)) {
      await _read();
      print('Creado con éxito');
    } else {
      NotificationsService.error(listce.payload.toString());
    }
    _loadCreate = false;
    body = {};
    notifyListeners();
  }

  bool _loadDeleted = false;
  bool get loadDeleted => _loadDeleted;
  set loadDeleted(bool loadDeleted) => _loadDeleted = loadDeleted;
  late String id;
  Future<void> deleted() async {
    _loadDeleted = true;
    notifyListeners();
    final listce = await service.deleted(url, id);
    if ([200, 201].contains(listce.code)) {
      await _read();
      print('Eliminado con exito');
    } else {
      NotificationsService.error(listce.payload.toString());
    }
    _loadDeleted = false;
    notifyListeners();
  }

  bool _loadUpdate = false;
  bool get loadUpdate => _loadUpdate;
  set loadUpdate(bool loadUpdate) => _loadUpdate = loadUpdate;
  late Map<String, dynamic> bodyUpdate = {};
  Future<void> update() async {
    _loadUpdate = true;
    notifyListeners();
    final listce = await service.update(url, bodyUpdate);
    if ([200, 201].contains(listce.code)) {
      await _read();
      print('Acualizado con éxito');
    } else {
      NotificationsService.error(listce.payload.toString());
    }
    _loadUpdate = false;
    bodyUpdate = {};
    notifyListeners();
  }
  void filter(String filter, List<String> fields) {

    _listFilter = _list
        .where((field) =>
            fields.map((d) => field.toMap()[d]).join(" ")
                .toUpperCase()
                .contains(filter.toUpperCase()))
        .toList();
    notifyListeners();
  }
}
