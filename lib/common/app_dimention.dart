import 'package:flutter/material.dart';

extension AppWidthHeight on BuildContext {
  double get screenWidth {
    double screenWidth = MediaQuery.of(this).size.width;
    return screenWidth;
  }

  double get screenHeight {
    double screenHeight = MediaQuery.of(this).size.height;
    return screenHeight;
  }
}
