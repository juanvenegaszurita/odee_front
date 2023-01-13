import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:odee_front/src/cross/globals.dart';
/* import 'package:odee_front/src/services/services.dart'; */

class AuthService {
  final storage = const FlutterSecureStorage();

  /* Singleton */
  static final AuthService _authService = AuthService._();
  factory AuthService() {
    return _authService;
  }
  AuthService._();

  Future<String?> login(String email, String password) async {
    final Map<String, String> body = {
      "email": email,
      "password": password,
      "token": '',
    };
    final resp = await http.post(
      Globals.getUri("/login"),
      headers: await Globals.getHeader(),
      body: json.encode(body),
    );
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    if ([200, 201].contains(resp.statusCode)) {
      storage.write(
        key: "token",
        value: decodeResp['payload']['token_firebase'],
      );
      return null;
    } else {
      return decodeResp['payload'];
    }
  }

  Future<void> logout() async {
    await storage.delete(key: "token");
  }

  Future<String> readToken() async {
    return await storage.read(key: "token") ?? "";
  }
}
