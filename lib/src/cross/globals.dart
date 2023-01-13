import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/menu_option.model.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
    
import '../services/auth.service.dart';

class Globals {
  static const String defaultLanguage = 'es';
  static const supportedLocales = [
    'en',
    'es',
  ];

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "en", value: translate('language.name.en')), //English
    MenuOptionsModel(key: "es", value: translate('language.name.es')), //Spanish
  ];

  static Uri getUri(String path) {
    const String baseUrl = "localhost:3000";
    const String pathInicial = "/api-odee/v1";
    final url = Uri.http(baseUrl, "$pathInicial$path");
    return url;
  }

  static Future<Map<String, String>> getHeader() async {
    AuthService as = AuthService();
    String token = await as.readToken();
    Map<String, String> h = {
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "plataforma": defaultTargetPlatform.name
    };
    return h;
  }
}
