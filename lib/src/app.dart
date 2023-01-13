import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:odee_front/src/cross/cross.dart';
import 'package:odee_front/src/pages/pages.dart';
import 'package:odee_front/src/providers/providers.dart';

import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/services/services.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.theme,
    required this.themeDark,
  });

  final ThemeData theme;
  final ThemeData themeDark;

  @override
  Widget build(BuildContext context) {
    LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;
    return MaterialApp(
      scaffoldMessengerKey: NotificationsService.messengerKey,
      navigatorKey: NotificationsService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "App",
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localeFromString(
          Provider.of<SettingProvider>(context).defaultLanguage),
      //initialRoute: CheckAuthPage.route,
      initialRoute: "checkAuth",
      routes: routes,
      theme: theme,
      darkTheme: themeDark,
      themeMode: Provider.of<SettingProvider>(context).themeMode,
    );
  }
}
