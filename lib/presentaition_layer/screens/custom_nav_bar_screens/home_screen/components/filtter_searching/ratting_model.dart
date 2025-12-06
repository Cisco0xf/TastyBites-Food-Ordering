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
