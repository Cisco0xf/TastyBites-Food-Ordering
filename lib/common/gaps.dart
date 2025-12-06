import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.hRatio,
    this.height = 0.0,
    this.wRatio,
    this.width = 0.0,
  });

  final double? hRatio;
  final double? wRatio;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hRatio != null ? context.screenHeight * hRatio! : height,
      width: wRatio != null ? context.screenWidth * wRatio! : width,
    );
  }
}
