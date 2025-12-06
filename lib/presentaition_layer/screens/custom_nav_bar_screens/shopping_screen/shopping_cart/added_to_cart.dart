import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddedToCartSuccessfullyWidget extends StatefulWidget {
  const AddedToCartSuccessfullyWidget({
    super.key,
    required this.item,
  });

  final FoodModel item;

  @override
  State<AddedToCartSuccessfullyWidget> createState() =>
      _AddedToCartSuccessfullyWidgetState();
}

class _AddedToCartSuccessfullyWidgetState
    extends State<AddedToCartSuccessfullyWidget> with TickerProviderStateMixin {
  late AnimationController _doneController;
  @override
  void initState() {
    _doneController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    // _doneController.reset();
    _doneController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _doneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: context.screenWidth * .17,
                height: context.screenHeight * .06,
                child: Lottie.asset(
                  controller: _doneController,
                  "asstes/animations/done.json",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: context.screenWidth * .7,
                    child: Text(
                      widget.item.foodName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: FontFamily.mainFont,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "added_to__cart".localeValue(context: context),
                    style: TextStyle(
                      fontFamily: context.isEnglish
                          ? FontFamily.mainFont
                          : FontFamily.mainArabic,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: borderRaduis(10),
              color: SwitchColors.itemPriceInAddedToCart,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "item_price".localeValue(context: context),
                  style: TextStyle(
                    fontFamily: context.isEnglish
                        ? FontFamily.mainFont
                        : FontFamily.mainArabic,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "${widget.item.foodPrice} \$",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.mainFont,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            width: double.infinity,
            height: context.screenHeight * .06,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                shape: ContinuousRectangleBorder(
                  borderRadius: borderRaduis(10),
                ),
                side: const BorderSide(
                  color: Colors.orange,
                ),
              ),
              child: Text(
                "see_more_products".localeValue(context: context),
                style: TextStyle(
                  color: Colors.orange,
                  fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: context.screenWidth,
            child: Consumer<CurrentIndexProvider>(
              builder: (context, moveToCart, child) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.pop(context); // Close bottomSheet
                    Navigator.pop(context); // Close details screen
                    moveToCart.switchContent(3);
                  },
                  color: Colors.orange,
                  height: context.screenHeight * .06,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "show_cart".localeValue(context: context),
                    style: TextStyle(
                      fontFamily: context.isEnglish
                          ? FontFamily.mainFont
                          : FontFamily.mainArabic,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
