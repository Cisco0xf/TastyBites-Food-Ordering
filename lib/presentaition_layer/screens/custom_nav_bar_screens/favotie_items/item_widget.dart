import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/global_box_shadow.dart';
import 'package:provider/provider.dart';

typedef Discover = void Function();

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    super.key,
    required this.discover,
    required this.item,
  });

  final FoodModel item;
  final Discover discover;

  String get _rate => double.parse(item.foodRate.toString()).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(6.0),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(15),
        gradient: LinearGradient(
          colors: SwitchColor.itemGradeint,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: context.isLight ? globalBoxShadow : null,
      ),
      child: Clicker(
        onClick: discover,
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: context.screenWidth * .3,
                  height: context.screenHeight * .15,
                  child: ClipRRect(
                    borderRadius: borderRaduis(15),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: padding(5.0, from: From.horizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: context.screenWidth * .5,
                        child: Text(
                          item.foodName,
                          style: const TextStyle(
                            fontFamily: FontFamily.mainFont,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: padding(5),
                        margin: padding(3),
                        decoration: BoxDecoration(
                          borderRadius: borderRaduis(7),
                          color: Colors.black12,
                        ),
                        child: Text(
                          "${double.parse(
                            item.foodPrice.toString(),
                          ).toStringAsFixed(2)} \$",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                _rate,
                                style: const TextStyle(
                                  color: Colors.yellow,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  (${item.numberOfReviewers} reviewer)",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: context.isEnglish ? 3 : null,
              left: context.isEnglish ? null : 3,
              child: Consumer<WishListProvider>(
                builder: (context, wishList, child) {
                  return GestureDetector(
                    onTap: () async {
                      await wishList.removeItemFromFirestoreWishList(item);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Color(0xFFFF5B22),
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
