// ignore: file_names
import 'package:odee_front/src/cross/BaseConfig.dart';

import 'ProdConfig.dart';
import 'DevConfig.dart';
import 'LocalConfig.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  static final Environment _singleton = Environment();

  static const String DEV = 'DEV';
  static const String LOCAL = 'LOCAL';
  static const String PROD = 'PROD';

  //BaseConfig config;

  initConfig(String environment) {
    // config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.LOCAL:
        return LocalConfig();
      case Environment.DEV:
        return DevConfig();
      default:
        return ProdConfig();
    }
  }
}