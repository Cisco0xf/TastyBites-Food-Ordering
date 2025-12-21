import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/global_dishes/ratting_sector.dart';

class GlobalBody extends StatelessWidget {
  const GlobalBody({super.key, required this.item});

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: SwitchColor.bgColor),
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Gap(hRatio: 0.27),
            Padding(
              padding: padding(from: From.horizontal, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.foodName,
                          style: const TextStyle(
                            fontFamily: FontFamily.mainFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        if (item.dishCountryFlag != null)
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: borderRaduis(7),
                                ),
                                width: context.screenWidth * .11,
                                height: context.screenHeight * .04,
                                child: ClipRRect(
                                  borderRadius: borderRaduis(7),
                                  child: SvgPicture.asset(
                                    fit: BoxFit.cover,
                                    item.dishCountryFlag!,
                                  ),
                                ),
                              ),
                              const Gap(height: 10.0),
                              Text(
                                item.dishCountry ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontFamily.subFont,
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "${item.foodPrice} \$",
                      style: const TextStyle(
                        fontFamily: FontFamily.subFont,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(hRatio: 0.01),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.screenWidth * .55,
                    child: ItemDescription(description: item.description),
                  ),
                  const ReviewersSector(),
                ],
              ),
            ),
            // ING LIST HRER
            IngerdeintsItems(item: item),
            const Gap(hRatio: 0.09),
          ],
        ),
      ),
    );
  }
}
