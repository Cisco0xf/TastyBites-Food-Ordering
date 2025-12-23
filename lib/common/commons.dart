import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/global_dishes/global_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/salads_vegetarian/details_of_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

BorderRadius borderRaduis(double raduis, {Side side = Side.all}) {
  final Map<Side, BorderRadius> raduisMap = {
    Side.all: BorderRadius.circular(raduis),
    Side.top: BorderRadius.vertical(top: Radius.circular(raduis)),
    Side.left: BorderRadius.horizontal(left: Radius.circular(raduis)),
    Side.bottom: BorderRadius.vertical(bottom: Radius.circular(raduis)),
    Side.right: BorderRadius.horizontal(right: Radius.circular(raduis)),
  };

  return raduisMap[side]!;
}

EdgeInsetsGeometry padding(double padding, {From from = From.all}) {
  final Map<From, EdgeInsets> paddingMap = {
    From.all: EdgeInsets.all(padding),
    From.vertical: EdgeInsets.symmetric(vertical: padding),
    From.horizontal: EdgeInsets.symmetric(horizontal: padding),
  };

  return paddingMap[from]!;
}

class Clicker extends StatelessWidget {
  const Clicker({
    super.key,
    this.isCircular = false,
    required this.onClick,
    this.innerPadding = 7.0,
    this.raduis = 10.0,
    required this.child,
  });
  final double raduis;
  final double innerPadding;
  final void Function() onClick;
  final bool isCircular;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        borderRadius: isCircular ? null : borderRaduis(raduis),
        customBorder: isCircular ? const CircleBorder() : null,
        child: Padding(
          padding: padding(innerPadding),
          child: child,
        ),
      ),
    );
  }
}


void showToastification({
  required String message,
  Color progressBarColor = const Color(0xFFEE9322),
  ToastificationType type = ToastificationType.info,
  bool showProgressBar = false,
}) {
  final BuildContext context = navigationKey.currentContext!;
  toastification.show(
    context: context,
    applyBlurEffect: true,
    dragToClose: true,
    showProgressBar: showProgressBar,
    autoCloseDuration: const Duration(seconds: 2),
    direction: context.isEnglish ? TextDirection.ltr : TextDirection.rtl,
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 250),
    progressBarTheme: ProgressIndicatorThemeData(
      color: progressBarColor,
    ),
    type: type,
    description: Text(
      message,
      textAlign: context.isEnglish ? TextAlign.left : TextAlign.right,
      style: TextStyle(
        fontFamily:
            context.isEnglish ? FontFamily.mainFont : FontFamily.mainArabic,
        fontSize: 14,
      ),
    ),
  );
}


void pushTo(Widget target, {Push type = Push.push}) {
  final BuildContext context = navigationKey.currentContext as BuildContext;
  switch (type) {
    case Push.clear:
      {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            return target;
          },
        ), (root) => false);

        return;
      }
    case Push.push:
      {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => target,
          ),
        );
        return;
      }
    case Push.replace:
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => target,
        ));
        return;
      }
  }
}

void popScreen() {
  final BuildContext context = navigationKey.currentContext as BuildContext;

  Navigator.of(context).pop();
}

class CheckDivider extends StatelessWidget {
  const CheckDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      thickness: 2,
      endIndent: 20,
      indent: 20,
    );
  }
}

Widget customRouts(FoodModel item) {
  final Widget defaultRout = FoodDetails(item: item);

  final Map<String, Widget> routs = {
    "Salad": ShowDishesDetailsWidget(item: item),
    "Vegetarian": ShowDishesDetailsWidget(item: item),
    "GlobalDishe": GlobalDishesDetails(item: item),
  };

  final Widget target = routs[item.foodType] ?? defaultRout;

  return target;
}

class ItemRating extends StatelessWidget {
  const ItemRating({super.key, required this.rate, this.size = 30.0});

  final double rate;
  final double size;

  @override
  Widget build(BuildContext context) {

    return RatingBar(
      maxRating: 5.0,
      minRating: 0.0,
      itemCount: 5,
      itemSize: size,
      direction: Axis.horizontal,
      initialRating: rate,
      allowHalfRating: true,
      tapOnlyMode: true,
      ignoreGestures: true,
      ratingWidget: RatingWidget(
          full: const Icon(Icons.star_rate_rounded, color: Colors.amber),
          half: const Icon(Icons.star_half_rounded, color: Colors.amber),
          empty: const Icon(Icons.star_rate_rounded, color: Colors.grey)),
      onRatingUpdate: (double rating) {},
    );
  }
}

class IngerdeintsItems extends StatelessWidget {
  const IngerdeintsItems({super.key, required this.item, this.isGreen = false});

  final FoodModel item;
  final bool isGreen;

  Color get _borderColor =>
      isGreen ? const Color(0xFFc6ff00) : SwitchColor.primaryO;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "INGREDIENTS",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (item.ingredientsImages != null)
          SizedBox(
            height: context.screenHeight * .17,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.ingredientsImages!.length,
              itemBuilder: (context, index) {
                return SizedBox.square(
                  dimension: context.screenHeight * .16,
                  child: Container(
                    margin: padding(7),
                    decoration: BoxDecoration(
                      border: Border.all(color: _borderColor),
                      borderRadius: borderRaduis(15),
                      color: context.isLight ? Colors.white : Colors.black38,
                    ),
                    child: item.ingredientsImages != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox.square(
                                dimension: context.screenHeight * .1,
                                child: Image.asset(
                                  item.ingredientsImages![index],
                                ),
                              ),
                              Text(item.ingredientsNames![index])
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class ItemTitle extends StatelessWidget {
  const ItemTitle({super.key, required this.item});

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(20.0, from: From.horizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                item.foodName,
                style: TextStyle(
                  fontFamily: FontFamily.mainFont,
                  fontWeight: FontWeight.bold,
                  color: SwitchColor.txtColor,
                  fontSize: 20,
                ),
              ),
              const Gap(height: 6.0),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "CALORIES: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "${item.calories} cal",
                      style: TextStyle(
                        fontSize: 14,
                        color: SwitchColor.txtColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${item.foodPrice} \$",
            style: const TextStyle(
              fontFamily: FontFamily.subFont,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0FA958),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemDescription extends StatelessWidget {
  const ItemDescription({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Gap(width: 10.0),
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        Padding(
          padding: padding(10.0),
          child: Text(
            description,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            style: const TextStyle(
              fontSize: 17,
              fontFamily: FontFamily.subFont,
            ),
          ),
        ),
      ],
    );
  }
}

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentCategory =
        context.watch<CurrentIndexProvider>().currentIndex;

    final String categoryLabel = categoriesItems[currentCategory].itemTitle;

    final String localizedCat = categoryLabel.localeValue(context: context);

    final String label =
        "${"not_found".localeValue(context: context)} \"$localizedCat\"";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: context.screenWidth * .88,
          height: context.screenHeight * .3,
          child: SvgPicture.asset(Assets.emptyCart),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.isEnglish ? 20 : 17,
            fontFamily:
                context.isEnglish ? FontFamily.coolFont : FontFamily.mainArabic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(height: 20),
        Consumer<SearchingProvider>(
          builder: (context, clearSearching, child) {
            return SizedBox(
              width: context.screenWidth * .6,
              height: context.screenHeight * .06,
              child: MaterialButton(
                onPressed: () => clearSearching.clearFilterAndSearch(),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRaduis(15),
                ),
                color: SwitchColor.primaryO,
                child: Text(
                  "see_recomended".localeValue(context: context),
                  style: TextStyle(
                    fontSize: context.isEnglish ? 15 : 17,
                    fontFamily:
                        context.isEnglish ? null : FontFamily.mainArabic,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}


/* 
class LoadingState<T extends ChangeNotifier> extends StatelessWidget {
  const LoadingState({super.key, required this.child, required this.provider});

  final Widget child;
  final T provider;

  @override
  Widget build(BuildContext context) {
    return context.watch<T>().isOperating
        ? LoadingAnimationWidget.inkDrop(
            color: Colors.orange,
            size: 30.0,
          )
        : child;
  }
}
 */