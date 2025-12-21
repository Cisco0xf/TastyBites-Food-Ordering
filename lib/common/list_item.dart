import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/add_icon_btn.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';

class ListFoodItem extends StatelessWidget {
  const ListFoodItem({
    super.key,
    /* required this.index,
    required this.foodList, */
    required this.item,
    required this.onTap,
    this.isGreen = false,
  });

  /* final int index;
  final List<FoodModel> foodList; */

  final void Function() onTap;
  final FoodModel item;

  final bool isGreen;

  Color get _itemColor => isGreen ? Colors.green : SwitchColor.primaryO;

  Color get _btnColor =>
      isGreen ? const Color(0xFF1b5e20) : SwitchColor.btnColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: _itemColor.withOpacity(0.8),
      ),
      child: Clicker(
        onClick: onTap,
        innerPadding: 0.0,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IntrinsicHeight(
                child: SizedBox(
                  width: context.screenWidth * .4,
                  child: Hero(
                    tag: item.foodName,
                    child: ClipRRect(
                      borderRadius: borderRaduis(20.0, side: Side.left),
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: context.screenWidth * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: context.screenWidth * .45,
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.foodName,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.mainFont,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${item.foodPrice.toString()} \$",
                          style: typePriceTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFD841F),
                            ),
                            Text(
                              item.foodRate.toString(),
                              style: const TextStyle(
                                color: Color(0xFFFD841F),
                              ),
                            ),
                          ],
                        ),
                        const Gap(wRatio: 0.03),
                        Text(
                          "(${item.numberOfReviewers} reviewer)",
                          style: const TextStyle(
                            fontFamily: FontFamily.subFont,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OrderButtonWidget(
                          item: item,
                          buttonColor: _btnColor,
                        ),
                        const Gap(wRatio: 0.03),
                        CartIconButton(target: item),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
