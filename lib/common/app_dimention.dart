import 'package:flutter/material.dart';

extension AppWidthHeight on BuildContext {
  double get screenWidth {
    double screenWidth = MediaQuery.sizeOf(this).width;
    return screenWidth;
  }

  double get screenHeight {
    double screenHeight = MediaQuery.sizeOf(this).height;
    return screenHeight;
  }
}
