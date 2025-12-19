import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

Future<void> showRemoveCartItemDialog(
  BuildContext context, {
  required FoodModel item,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return RemoveItemFromCart(item: item);
    },
  );
}

class RemoveItemFromCart extends StatelessWidget {
  const RemoveItemFromCart({super.key, required this.item});

  final FoodModel item;

  String removeLabel(BuildContext context) {
    final String clear = "remove_item".localeValue(context: context);
    final String cart = "from_cart".localeValue(context: context);
    final String itemname = item.foodName;

    final String fullLabel = "$clear $itemname $cart";

    return fullLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: borderRaduis(15.0)),
      child: Padding(
        padding: padding(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox.square(
              dimension: context.screenHeight * .13,
              child: SvgPicture.asset(Assets.removeFromCart),
            ),
            const Gap(height: 15.0),
            Text(
              removeLabel(context),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                      borderRadius: borderRaduis(17),
                    ),
                    side: const BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                  child: Text(
                    "no".localeValue(context: context),
                    style: TextStyle(
                      color: Colors.orange,
                      fontFamily:
                          context.isEnglish ? null : FontFamily.mainArabic,
                      fontSize: context.isEnglish ? null : 16,
                    ),
                  ),
                ),
                Consumer<CartManager>(
                  builder: (context, cartRemove, child) {
                    return MaterialButton(
                      onPressed: () async {
                        await cartRemove.addFoodItemToFirestoreCart(item);

                        popScreen();
                      },
                      shape: ContinuousRectangleBorder(
                        borderRadius: borderRaduis(17),
                      ),
                      color: const Color(0xFFF3B664),
                      child: Text(
                        "remove".localeValue(context: context),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily:
                              context.isEnglish ? null : FontFamily.mainArabic,
                          fontSize: context.isEnglish ? null : 16,
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
