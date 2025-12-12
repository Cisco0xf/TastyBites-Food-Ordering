import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';

class OrderPlaceWidget extends StatelessWidget {
  const OrderPlaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (context, chooseOrderPlace, child) {
        return Container(
          margin: padding(10.0),
          padding: padding(5.0),
          decoration: BoxDecoration(
            borderRadius: borderRaduis(30.0),
            color: SwitchColors.orderPlaceBGColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(
              places.length,
              (index) {
                final PlaceModel place = places[index];
                return OrderChoice(
                  isSelected: place.type == chooseOrderPlace.orderPlace,
                  place: place,
                  onSelect: () {
                    chooseOrderPlace.placeSwitcher(place.type);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class OrderChoice extends StatelessWidget {
  const OrderChoice({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.place,
  });

  final PlaceModel place;
  final bool isSelected;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: context.screenWidth * .4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRaduis(25.0),
        color: isSelected ? SwitchColors.selectedPlaceColor : null,
      ),
      child: Clicker(
        onClick: onSelect,
        raduis: 20.0,
        child: Row(
          children: [
            SizedBox.square(
              dimension: context.screenHeight * .04,
              child: SvgPicture.asset(place.image),
            ),
            const Gap(width: 10.0),
            Text(
              place.label.localeValue(context: context),
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

class PlaceModel {
  final String image;
  final String label;
  final Place type;

  const PlaceModel({
    required this.image,
    required this.label,
    required this.type,
  });
}

const List<PlaceModel> places = [
  PlaceModel(
    image: Assets.rest,
    label: "restaurant",
    type: Place.restuarant,
  ),
  PlaceModel(
    image: Assets.delivary,
    label: "delivary_service",
    type: Place.takeaway,
  ),
];
