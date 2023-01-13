import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:odee_front/src/app.dart';
import 'package:odee_front/src/cross/cross.dart';
import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/services/services.dart';
import 'package:odee_front/src/share_preferences/preferences.dart';

import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  await Preferences.init();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeDarkStr =
      await rootBundle.loadString('assets/appainter_theme_dark.json');
  final themeJson = jsonDecode(themeStr);
  final themeDarkJson = jsonDecode(themeDarkStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final themeDark = ThemeDecoder.decodeThemeData(themeDarkJson)!;

  /* const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.LOCAL
  );

  Environment().initConfig(environment); */

  LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: Globals.defaultLanguage,
    supportedLocales: Globals.supportedLocales,
  );
  runApp(
    LocalizedApp(
      delegate,
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (contex) => AuthProvider()),
          ChangeNotifierProvider(
            create: (contex) => SettingProvider(
              themeMode: Preferences.themeMode,
              defaultLanguage: Preferences.defaultLanguage,
            ),
          ),
          ChangeNotifierProvider(
              create: (contex) => NotificationPushProvider()),
        ],
        child: App(
          theme: theme,
          themeDark: themeDark,
        ),
      ),
    ),
  );
}
