import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/pages/pages.dart';

Map<String, WidgetBuilder> routes = {
  /* Public */
  CheckAuthPage.route: (context) => const CheckAuthPage(),
  LoginPage.route: (context) => LoginPage(),
  SettingPage.route: (context) => const SettingPage(),
  /* private */
  "home": (context) => const HomePage(),
  EmpresasPage.route: (context) => const EmpresasPage(),
  DetalleEmpresaPage.route: (context) => const DetalleEmpresaPage(),
};

/* Map<String, Widget> routesMenuModel = {
  HomePage.title: HomePage(),
}; */

List<MenuModel> routesMenu = [
  MenuModel(
    title: "Menú principal",
    menuOptions: [
      RoutesMenuModel(
        name: EmpresasPage.title,
        page: const EmpresasPage(),
        icon: Icons.manage_accounts,
      ),
      RoutesMenuModel(
        name: ProdServPage.title,
        page: const ProdServPage(),
        icon: Icons.shop,
      ),
      RoutesMenuModel(
        name: TypeFilePage.title,
        page: const TypeFilePage(),
        icon: Icons.shop,
      ),
    ],
  ),
  MenuModel(
    title: "Ajustes sistemas",
    menuOptions: [
      RoutesMenuModel(
        name: SettingPage.title,
        page: const SettingPage(),
        icon: Icons.manage_accounts,
      ),
    ],
  )
];
