import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/filtter_searching/filter_sheet.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';

class ShowFilter extends StatelessWidget {
  const ShowFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: context.screenHeight * .06,
        width: context.screenWidth * .18,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
          left: context.isEnglish ? 10 : 0,
          right: context.isEnglish ? 0 : 10,
        ),
        decoration: BoxDecoration(
          color: SwitchColor.accent,
          borderRadius: borderRaduis(22),
        ),
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Icon(Icons.tune_rounded),
        ),
      ),
      onTap: () => showFilterSheet(),
    );
  }
}

class SelectPriceFilter extends StatelessWidget {
  const SelectPriceFilter({
    super.key,
    required this.imagePath,
    required this.priceRange,
    required this.isSelected,
    required this.onSelect,
  });

  final String imagePath;
  final String priceRange;
  final bool isSelected;
  final void Function() onSelect;

  Color get _selectedColor =>
      isSelected ? SwitchColor.primaryO : SwitchColor.fillColor;

  Border get _selectedBorder => isSelected
      ? Border.all(color: Colors.orange, width: 1.5)
      : Border.all(color: Colors.grey, width: 1);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: padding(10),
      width: context.screenWidth * .42,
      decoration: BoxDecoration(
        borderRadius: borderRaduis(isSelected ? 30 : 20),
        color: _selectedColor,
        border: _selectedBorder,
      ),
      child: Clicker(
        onClick: onSelect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox.square(
              dimension: context.screenHeight * .04,
              child: SvgPicture.asset(imagePath),
            ),
            Text(
              priceRange.localeValue(context: context),
              style: AppTextStyles.filterItemTextStyle(context: context),
            ),
          ],
        ),
      ),
    );
  }
}
