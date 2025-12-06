import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/global_box_shadow.dart';
import 'package:provider/provider.dart';

typedef Discover = void Function()?;

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    super.key,
    /*  required this.foodName,
    required this.foodRate,
    required this.foodPrice,
    required this.numberOfReviewers,
    required this.removedIndex,
    required this.imagePath, */
    required this.discover,
    required this.item,
  });

  /* final String foodName;
  final double foodPrice;
  final String imagePath;
  final double foodRate;
  final int removedIndex;
  final int numberOfReviewers; */
  final FoodModel item;
  final Discover discover;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(15),
        gradient: LinearGradient(
          colors: SwitchColors.favoriteItemsColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: context.isLight ? globalBoxShadow : null,
      ),
      child: Stack(
        children: [
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
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
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(3),
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
                              double.parse(
                                item.foodRate.toString(),
                              ).toStringAsFixed(1),
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
                    MaterialButton(
                      onPressed: discover,
                      color: SwitchColors.discoverButtonColor,
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.favorite,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "discover".localeValue(context: context),
                            style: TextStyle(
                              fontSize: context.isEnglish ? null : 17,
                              fontFamily: context.isEnglish
                                  ? FontFamily.mainFont
                                  : FontFamily.mainArabic,
                            ),
                          ),
                        ],
                      ),
                    )
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
              builder: (context, removeFromFavorite, child) {
                return GestureDetector(
                  onTap: () async {
                    /* removeFromFavorite.removeItemFromFavorite(
                      item: removeFromFavorite.favoriteItems[removedIndex],
                    ); */
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
    );
  }
}
