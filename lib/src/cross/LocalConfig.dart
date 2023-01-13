// ignore: file_names
import 'package:odee_front/src/cross/BaseConfig.dart';
class LocalConfig implements BaseConfig {
  @override
  String get base => "localhost:3000";
  @override
  String get api => "/dev/canal/rentalInsurance/v1";
}