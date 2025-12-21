import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/add_icon_btn.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:provider/provider.dart';

class DessertsWidget extends StatelessWidget {
  const DessertsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchingProvider>(
        builder: (context, searching, child) {
          return searching.searchingWithoutData
              ? const EmptySearch()
              : ListView.builder(
                  padding: EdgeInsets.only(bottom: context.screenHeight * .14),
                  itemCount: searching.filtred.length,
                  itemBuilder: (context, index) {
                    final FoodModel target = searching.filtred[index];

                    return DessertsItem(
                        item: target,
                        onTap: () {
                          pushTo(FoodDetails(item: target));
                        });
                  },
                );
        },
      ),
    );
  }
}

class DessertsItem extends StatelessWidget {
  const DessertsItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final FoodModel item;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Clicker(
          onClick: onTap,
          innerPadding: 0.0,
          child: Container(
            margin: padding(10.0),
            width: double.infinity,
            height: context.screenHeight * .3,
            decoration: BoxDecoration(
              borderRadius: borderRaduis(15),
              color: Colors.black26,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(item.imagePath),
              ),
            ),
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            margin: padding(10, from: From.horizontal),
            decoration: BoxDecoration(
              borderRadius: borderRaduis(20),
              gradient: LinearGradient(
                colors: SwitchColor.itemGradeint,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Clicker(
              onClick: onTap,
              innerPadding: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.foodName,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${item.foodPrice.toString()}  \$",
                    style: typePriceTextStyle,
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          Text(
                            item.foodRate.toString(),
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontFamily: FontFamily.mainFont,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "   (${item.numberOfReviewers} reviewer)",
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: FontFamily.subFont,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OrderButtonWidget(item: item),
                      /* IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle, size: 35),
                      ), */
                      CartIconButton(target: item),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
