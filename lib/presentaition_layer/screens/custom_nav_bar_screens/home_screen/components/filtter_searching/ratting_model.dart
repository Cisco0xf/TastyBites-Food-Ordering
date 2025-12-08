import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/constants/enums.dart';

class RattingModel {
  final String title;
  final String subTitle;
  final RateFilter type;
  RattingModel({
    required this.title,
    required this.subTitle,
    required this.type,
  });
}

List<RattingModel> ratting = [
  RattingModel(
    title: "any_rate",
    subTitle: "any_sub",
    type: RateFilter.any,
  ),
  RattingModel(
    title: "good_rate",
    subTitle: "good_sub",
    type: RateFilter.medium,
  ),
  RattingModel(
    title: "excellent",
    subTitle: "excellent_sub",
    type: RateFilter.high,
  ),
];

class PriceModel {
  final String type;
  final String imagePath;

  const PriceModel({
    required this.imagePath,
    required this.type,
  });
}

const List<PriceModel> priceFilters = <PriceModel>[
  PriceModel(imagePath: Assets.all, type: "all_price"),
  PriceModel(imagePath: Assets.cheap, type: "cheap_price"),
  PriceModel(imagePath: Assets.meduim, type: "medium_price"),
  PriceModel(imagePath: Assets.expencive, type: "high_price"),
];
