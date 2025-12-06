import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

class RemoveItemFromCartWidget extends StatelessWidget {
  const RemoveItemFromCartWidget({
    super.key,
    required this.item,
  });
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -15,
      left: context.isEnglish ? null : -10,
      right: context.isEnglish ? -10 : null,
      child: SizedBox(
        width: context.screenWidth * .1,
        height: context.screenHeight * .07,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  insetPadding: const EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    "${"remove_item".localeValue(context: context)} \"${item.foodName}\" ${"from_cart".localeValue(context: context)} ",
                    style: TextStyle(
                      fontFamily: context.isEnglish
                          ? FontFamily.mainFont
                          : FontFamily.mainArabic,
                      fontSize: 18,
                    ),
                  ),
                  actions: <Widget>[
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
                      builder: (context, removeFromCart, child) {
                        return MaterialButton(
                          onPressed: () async {
                            await removeFromCart
                                .removeItemFromCart(item)
                                .whenComplete(
                              () {
                                Navigator.pop(context);
                                ReusableMethods.showtoastification(
                                  message: "Item removed from cart",
                                );
                              },
                            );
                          },
                          shape: ContinuousRectangleBorder(
                            borderRadius: borderRaduis(17),
                          ),
                          color: const Color(0xFFF3B664),
                          child: Text(
                            "remove".localeValue(context: context),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: context.isEnglish
                                  ? null
                                  : FontFamily.mainArabic,
                              fontSize: context.isEnglish ? null : 16,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                  content: SizedBox(
                    height: context.screenHeight * .13,
                    child: ClipRRect(
                      borderRadius: borderRaduis(15),
                      child: SvgPicture.asset(
                        "asstes/images/app_images/screens_images/remove_from_cart.svg",
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.close,
            size: 20,
          ),
        ),
      ),
    );
  }
}
