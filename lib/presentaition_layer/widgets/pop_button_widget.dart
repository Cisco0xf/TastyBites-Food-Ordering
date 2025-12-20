import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/favotie_items/item_widget.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';

class PopBtn extends StatelessWidget {
  const PopBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(10.0),
      child: ClipRRect(
        borderRadius: borderRaduis(8.0),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRaduis(8.0),
                border: Border.all(color: SwitchColor.borderColor),
                color: context.isLight ? Colors.black26 : Colors.white12,
              ),
              child: Clicker(
                innerPadding: 10.0,
                onClick: () => popScreen(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
