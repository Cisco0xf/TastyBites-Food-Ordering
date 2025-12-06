import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_models/salads_demo_data.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/show_dishes.dart';

class SaladsTypeWidget extends StatelessWidget {
  const SaladsTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowDishWidget(
      typeList: saladDamoData,
    );
  }
}
