import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }
}

extension ResponsiveExt on num {
  double get h => (this / 100) * SizeConfig.screenHeight;

  double get w => (this / 100) * SizeConfig.screenWidth;

  double get fs => (this / 100) * SizeConfig.screenHeight;

  double get r => (this / 100) * SizeConfig.screenWidth;
}
