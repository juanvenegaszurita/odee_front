import 'package:odee_front/src/models/models.dart';

// Model class to hold menu option data (language and theme)
class MenuModel {
  final String title;
  final List<RoutesMenuModel> menuOptions;

  MenuModel({
    required this.title,
    required this.menuOptions,
  });
}
