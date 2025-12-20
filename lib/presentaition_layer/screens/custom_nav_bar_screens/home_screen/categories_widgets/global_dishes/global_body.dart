import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/ratting_sector.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';

class GlobalBody extends StatelessWidget {
  const GlobalBody({super.key, required this.item});

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.screenHeight * .27,
      ),
      decoration: BoxDecoration(
        color: SwitchColor.bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                const SizedBox(
                                  width: 10,
                                ),
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
                          color: Color(0xFF0FA958),
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
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              item.description,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: FontFamily.subFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const ReviewersSector(),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "INGREDIENTS",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              if (item.ingredientsImages != null)
                Container(
                  padding: EdgeInsets.only(
                    bottom: context.screenHeight * .09,
                  ),
                  width: context.screenWidth,
                  height: context.screenHeight * .3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item.ingredientsImages!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: padding(7),
                        margin: padding(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFFF8551),
                            width: 2,
                          ),
                          borderRadius: borderRaduis(15),
                          color:
                              context.isLight ? Colors.white : Colors.black38,
                        ),
                        child: item.ingredientsImages != null
                            ? Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: context.screenWidth * .3,
                                    height: context.screenHeight * .1,
                                    child: Image.asset(
                                      item.ingredientsImages![index],
                                    ),
                                  ),
                                  Text(item.ingredientsNames![index])
                                ],
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
