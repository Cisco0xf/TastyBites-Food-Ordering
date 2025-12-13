import 'package:flutter/material.dart';
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
  });

  final Color buttonColor;
  final String orderTitle;
  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    CurrentIndexProvider currentIndex =
        Provider.of<CurrentIndexProvider>(context, listen: false);
    return Consumer<SingleItemProvider>(
      builder: (context, orderNow, child) {
        return MaterialButton(
          onPressed: () {
            orderNow.item(item: item);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ChickOutWidget(isSingleItem: true);
                },
              ),
            );
          },
          color:
              currentIndex.currentIndex == 3 || currentIndex.currentIndex == 4
                  ? buttonColor
                  : context.isLight
                      ? AppLightColors.orderButtonColor
                      : AppDarkColors.orderButtonColor,
          child: Text(
            orderTitle.localeValue(context: context),
            style: AppTextStyles.orderNowButtonTextStyle(
              context: context,
            ),
          ),
        );
      },
    );
  }
}
