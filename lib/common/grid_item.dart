import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/add_icon_btn.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';

class GridFoodItem extends StatelessWidget {
  const GridFoodItem({
    super.key,
    /*   required this.drinkList,
    required this.index, */
    required this.item,
    required this.onTap,
  });
  /* 
  final int index;
  final List<FoodModel> drinkList; */

  final FoodModel item;
  final void Function() onTap;

  String get _price => item.foodPrice.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: SwitchColor.primaryO,
        border: Border.all(color: SwitchColor.borderColor),
      ),
      margin: padding(7.0),
      child: Clicker(
        onClick: onTap,
        innerPadding: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicWidth(
                child: SizedBox(
                  height: context.screenHeight * .2,
                  child: ClipRRect(
                    borderRadius: borderRaduis(20),
                    child: Hero(
                      tag: item.foodName,
                      child: Image.asset(item.imagePath, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: borderRaduis(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: padding(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.foodName,
                              overflow: TextOverflow.ellipsis,
                              style: typeNameTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.screenHeight * .04,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "$_price \$",
                                style: typePriceTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFF9F54B),
                              ),
                              Text(
                                item.foodRate.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Color(0xFFF9F54B),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "   (${item.numberOfReviewers.toString()}) reviewer",
                            style: const TextStyle(
                              fontFamily: FontFamily.subFont,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OrderButtonWidget(item: item),
                        CartIconButton(target: item),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
