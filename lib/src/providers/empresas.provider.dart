import 'package:flutter/material.dart';
import 'package:odee_front/src/models/business.mode.dart';
import 'package:odee_front/src/services/services.dart';

class EmpresasProvider with ChangeNotifier {
  bool _loadRead = false;
  List<BusinessModel> _list = [];
  List<BusinessModel> get list => _list;
  List<BusinessModel> _listFilter = [];
  List<BusinessModel> get listFilter => _listFilter;
  bool get loadRead => _loadRead;
  set loadRead(bool loadRead) => _loadRead = loadRead;

  final BusinessService service = BusinessService();

  TextEditingController filterController = TextEditingController();

  EmpresasProvider() {
    readAll();
  }

  Future<void> readAll() async {
    _loadRead = true;
    notifyListeners();

    final listce = await service.readAll();
    if ([200, 201].contains(listce.code)) {
      _list.clear();
      listce.payload
          .sort(((a, b) => b.clients!.length.compareTo(a.clients!.length)));
      _list = listce.payload;
      _listFilter.clear();
      _listFilter = listce.payload;
    } else {
      NotificationsService.error(listce.payload.toString());
    }

    _loadRead = false;
    notifyListeners();
  }

  void filter(String filter, List<String> fields) {
    _listFilter = _list
        .where((field) =>
            field.toString().toUpperCase().contains(filter.toUpperCase()))
        .toList();
    /* _listFilter.forEach((l) {
      final c = _list
          .where((ll) => ll.id == l.id);
      l.clients = filter == ''? c.first.clients : c.first.clients
          ?.where(
              (e) => e.toString().toUpperCase().contains(filter.toUpperCase()))
          .toList();
    }); */
    notifyListeners();
  }
}
