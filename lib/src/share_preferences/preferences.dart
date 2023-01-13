import 'package:flutter/material.dart';
import 'package:odee_front/src/cross/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _defaultLanguage = Globals.defaultLanguage;
  static String _themeSelected = ThemeSelectedEnum.light.name;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get defaultLanguage {
    return _prefs.getString('defaultLanguage') ?? _defaultLanguage;
  }

  static set defaultLanguage(String defaultLanguage) {
    _defaultLanguage = defaultLanguage;
    _prefs.setString('defaultLanguage', defaultLanguage);
  }

  static String get themeSelected {
    return _prefs.getString('themeSelected') ?? _themeSelected;
  }

  static setThemeSelected(ThemeSelectedEnum themeSelected) {
    _themeSelected = themeSelected.name;
    _prefs.setString('themeSelected', themeSelected.name);
  }

  static ThemeSelectedEnum get themeSelectedEnum {
    List<ThemeSelectedEnum> ts =
        ThemeSelectedEnum.values.where((e) => e.name == themeSelected).toList();
    if (ts.isEmpty) {
      return ThemeSelectedEnum.light;
    } else {
      return ts[0];
    }
  }

  static ThemeMode get themeMode {
    List<ThemeSelectedEnum> ts =
        ThemeSelectedEnum.values.where((e) => e.name == themeSelected).toList();
    if (ts.isEmpty) return ThemeMode.system;
    switch (ts[0]) {
      case ThemeSelectedEnum.system:
        return ThemeMode.system;
      case ThemeSelectedEnum.dark:
        return ThemeMode.dark;
      case ThemeSelectedEnum.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}

enum ThemeSelectedEnum { system, dark, light }
