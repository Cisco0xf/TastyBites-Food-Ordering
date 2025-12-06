import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';

class OrderPlaceWidget extends StatefulWidget {
  const OrderPlaceWidget({super.key});

  @override
  State<OrderPlaceWidget> createState() => _OrderPlaceWidgetState();
}

class _OrderPlaceWidgetState extends State<OrderPlaceWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (context, chooseOrderPlace, child) {
        return Container(
          margin: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: borderRaduis(15),
            color: SwitchColors.orderPlaceBGColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Consumer<AddressProvider>(builder: (context, clearError, child) {
                return GestureDetector(
                  /* onClick: () {
                    if (chooseOrderPlace.isTakeaway) {
                      //chooseOrderPlace.atResturent();
                      chooseOrderPlace.placeSwitcher(Place.restuarant);
                      clearError.clearError;
                    }
                  }, */
                  child: OrderChoiceWidget(
                    onSelect: () {
                      chooseOrderPlace.placeSwitcher(Place.restuarant);
                      clearError.clearError;
                    },
                    orderPlace: "restaurant".localeValue(context: context),
                    imagePath:
                        "asstes/images/app_images/chickout_place/restaurant.svg",
                    isSelected: !chooseOrderPlace.isTakeaway,
                  ),
                );
              }),
              GestureDetector(
                /*  onTap: () {
                  if (chooseOrderPlace.isRasturent) {
                    chooseOrderPlace.takeAway();
                  }
                }, */
                child: OrderChoiceWidget(
                  onSelect: () {
                    chooseOrderPlace.placeSwitcher(Place.takeaway);
                  },
                  orderPlace: "delivary_service".localeValue(context: context),
                  imagePath:
                      "asstes/images/app_images/chickout_place/delivery.svg",
                  isSelected: chooseOrderPlace.isTakeaway,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class OrderChoiceWidget extends StatelessWidget {
  const OrderChoiceWidget({
    super.key,
    required this.orderPlace,
    required this.isSelected,
    required this.imagePath,
    required this.onSelect,
  });

  final String orderPlace;
  final String imagePath;
  final bool isSelected;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      width: context.screenWidth * .4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: isSelected ? SwitchColors.selectedPlaceColor : null,
      ),
      child: Clicker(
        onClick: onSelect,
        child: Row(
          children: [
            SizedBox(
              width: context.screenWidth * .1,
              height: context.screenHeight * .04,
              child: SvgPicture.asset(imagePath),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              orderPlace,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
