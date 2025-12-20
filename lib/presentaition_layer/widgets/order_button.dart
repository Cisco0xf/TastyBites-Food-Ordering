import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/chick_out.dart';
import 'package:provider/provider.dart';

typedef OrderNow = void Function();

class OrderButtonWidget extends StatelessWidget {
  const OrderButtonWidget({
    super.key,
    this.buttonColor = const Color(0xFFef6c00),
    this.orderTitle = "order_now",
    required this.item,
    this.height,
    this.raduis,
    this.width,
  });

  final Color buttonColor;
  final String orderTitle;
  final FoodModel item;

  final double? width;
  final double? height;
  final double? raduis;

  ShapeBorder? get _borderRaduis => raduis != null
      ? RoundedRectangleBorder(borderRadius: borderRaduis(raduis!))
      : null;

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<CurrentIndexProvider>().currentIndex;
    final bool changeColor = currentIndex == 3 || currentIndex == 4;
    return Consumer<SingleItemProvider>(
      builder: (context, orderNow, child) {
        return SizedBox(
          width: width,
          height: height,
          child: MaterialButton(
            onPressed: () {
              orderNow.item(item: item);
              pushTo(const ChickOutWidget(isSingleItem: true));
            },
            color: changeColor ? buttonColor : SwitchColor.btnColor,
            shape: _borderRaduis,
            child: Text(
              orderTitle.localeValue(context: context),
              style: AppTextStyles.orderNowButtonTextStyle(
                context: context,
              ),
            ),
          ),
        );
      },
    );
  }
}
