import 'package:flutter/material.dart';

import 'package:odee_front/src/pages/pages.dart';
import 'package:odee_front/src/services/services.dart';

class AuthProvider with ChangeNotifier {
  final as = AuthService();
  bool _loadLogin = false;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool get loadLogin => _loadLogin;

  Future login(BuildContext context) async {
    _loadLogin = true;
    notifyListeners();
    final token = await as.login(
      emailController.value.text,
      passwordController.value.text,
    );
    _loadLogin = false;
    notifyListeners();
    if (token == null) {
      Navigator.pushReplacementNamed(context, "home");
    } else {
      NotificationsService.error(token);
    }
  }

  Future logOut(BuildContext context) async {
    await as.logout();
    Navigator.pushReplacementNamed(context, LoginPage.route);
  }
}
