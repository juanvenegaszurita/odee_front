import 'package:flutter/material.dart';

class PageUtils {
  /// Extra small screen / phone
  /// xs: 0px -575px
  static double xsMin = 0;
  static double xsMax = 575;
  /// */
  /// Small screen / phone
  /// sm: 576px - 767px
  /// */
  static double smMin = 576;
  static double smMax = 767;
  /// Medium screen / tablet
  ///md: 768px - 991px
  /// */
  static double mdMin = 768;
  static double mdMax = 991;
  /// Large screen / desktop
  /// lg: 992px - 1199px
  /// */
  static double lgMin = 992;
  static double lgMax = 1199;
  /// Extra large screen / wide desktop
  /// xl: 1200px
  /// */
  static double xlMin = 1200;
  static double xlMax = 2560;

  static const double maxWidth = 1240.0;
  
  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}