import 'package:flutter/material.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/pages/pages.dart';

Map<String, WidgetBuilder> routes = {
  /* Public */
  CheckAuthPage.route: (context) => const CheckAuthPage(),
  LoginPage.route: (context) => LoginPage(),
  SettingPage.route: (context) => const SettingPage(),
  FilePage.route: (context) => const FilePage(),
  RolePage.route: (context) => const RolePage(),
  UserPage.route: (context) => const RolePage(),
  BusinessPage.route: (context) => const RolePage(),
  ClientsPage.route: (context) => const RolePage(),
  /* private */
  "home": (context) => const HomePage(),
  EmpresasPage.route: (context) => const EmpresasPage(),
  DetalleEmpresaPage.route: (context) => const DetalleEmpresaPage(),
};

List<MenuModel> routesMenu = [
  MenuModel(
    title: "Acciones",
    menuOptions: [
      RoutesMenuModel(
        name: EmpresasPage.title,
        page: const EmpresasPage(),
        icon: Icons.business_center,
      ),
    ],
  ),
  MenuModel(
    title: "Mantenedores",
    menuOptions: [
      RoutesMenuModel(
        name: ClientsPage.title,
        page: const ClientsPage(),
        icon: Icons.settings,
      ),
      RoutesMenuModel(
        name: BusinessPage.title,
        page: const BusinessPage(),
        icon: Icons.settings,
      ),
      RoutesMenuModel(
        name: ProdServPage.title,
        page: const ProdServPage(),
        icon: Icons.settings,
      ),
      RoutesMenuModel(
        name: TypeFilePage.title,
        page: const TypeFilePage(),
        icon: Icons.settings,
      ),
      RoutesMenuModel(
        name: FilePage.title,
        page: const FilePage(),
        icon: Icons.settings,
      ),
      RoutesMenuModel(
        name: RolePage.title,
        page: const RolePage(),
        icon: Icons.settings,
      ),
      RoutesMenuModel(
        name: UserPage.title,
        page: const UserPage(),
        icon: Icons.settings,
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
