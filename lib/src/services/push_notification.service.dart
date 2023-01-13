import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

import 'package:odee_front/firebase_options.dart';
import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/services/services.dart';

// SHA1: 1D:4F:38:94:62:06:9F:C6:75:A7:73:BD:E4:B0:DA:27:80:B1:9D:F0
// P8 - KeyID: VYZH37GGZ9

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  /* static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackground Handler ${message.messageId}');
    print('onBackground body ${message.notification?.body}');
    print('onBackground title ${message.notification?.title}');
    print(message.data);
    NotificationsService.notificationsDialog(
      message.notification?.title ?? "",
      message.notification?.body ?? "",
    );
    final npp = Provider.of<NotificationPushProvider>(
        NotificationsService.navigatorKey.currentContext!,
        listen: false);
    npp.haveNotifications = true;
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessage Handler ${message.messageId}');
    print('onMessage body ${message.notification?.body}');
    print('onMessage title ${message.notification?.title}');
    print(message.data);
    NotificationsService.notificationsDialog(
      message.notification?.title ?? "",
      message.notification?.body ?? "",
    );
    final npp = Provider.of<NotificationPushProvider>(
        NotificationsService.navigatorKey.currentContext!,
        listen: false);
    npp.haveNotifications = true;
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp Handler ${message.messageId}');
    print('onMessageOpenApp body ${message.notification?.body}');
    print('onMessageOpenApp title ${message.notification?.title}');
    print(message.data);
    NotificationsService.notificationsDialog(
      message.notification?.title ?? "",
      message.notification?.body ?? "",
    );
    final npp = Provider.of<NotificationPushProvider>(
        NotificationsService.navigatorKey.currentContext!,
        listen: false);
    npp.haveNotifications = true;
  } */

  static Future initializeApp() async {
    // Push Notifications
    //await FirebaseCore().initializeApp(
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    /* if( !(defaultTargetPlatform == TargetPlatform.linux && !kIsWeb) ) {
      await requestPermission();

      token = await FirebaseMessaging.instance.getToken();
      print('Token: $token');

      // Handlers
      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
      FirebaseMessaging.onMessage.listen(_onMessageHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    } */
  }

  // Apple / Web
  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    print('User push notification status ${settings.authorizationStatus}');
  }
}
