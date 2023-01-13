import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static error(String content) {
    _mensaje(translate("mensage.error"), content);
  }
  static ok(String content) {
    _mensaje(translate("mensage.ok"), content);
  }
  static void _mensaje(String title, String content) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: title,
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Text(content),
        duration: const Duration(milliseconds: 1500),
        width: 500.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  static notificationsDialog(String title, String body) {
    showDialog(
      context: NotificationsService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(translate("button.accept")),
            )
          ],
        );
      },
    );
  }
}
