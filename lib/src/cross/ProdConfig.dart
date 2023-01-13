import 'package:odee_front/src/cross/BaseConfig.dart';

class ProdConfig implements BaseConfig {
  @override
  String get base => "localhost:3000";
  @override
  String get api => "/dev/canal/rentalInsurance/v1";
}