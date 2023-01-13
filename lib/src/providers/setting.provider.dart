import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:odee_front/src/cross/cross.dart';
import 'package:odee_front/src/share_preferences/preferences.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _defaultLanguage = Globals.defaultLanguage;

  SettingProvider({
    required ThemeMode themeMode,
    required String defaultLanguage,
  })  : _themeMode = themeMode,
        _defaultLanguage = defaultLanguage;

  ThemeMode get themeMode => _themeMode;
  void changeThemeMode() {
    Preferences.setThemeSelected(_themeMode == ThemeMode.light
        ? ThemeSelectedEnum.dark
        : ThemeSelectedEnum.light);
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  String get defaultLanguage => _defaultLanguage;
  set defaultLanguage(String defaultLanguage) {
    _defaultLanguage = defaultLanguage;
    notifyListeners();
  }
}
