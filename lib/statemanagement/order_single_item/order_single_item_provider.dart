import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/common/reusable_methods.dart';

class SingleItemProvider with ChangeNotifier {
  // Cach the ordered item
  late FoodModel orderedItem;
  void item({required FoodModel item}) {
    orderedItem = item;
    notifyListeners();
  }

  // Get total price

  double get getTotalOrderPrice {
    double totalOrderPrice = 0;
    if (orderedItem.foodType == "Sushi") {
      totalOrderPrice = double.parse(
        (orderedItem.foodPrice * orderedItem.stock / 5).toStringAsFixed(2),
      );
    } else {
      totalOrderPrice = double.parse(
        (orderedItem.foodPrice * orderedItem.stock).toStringAsFixed(2),
      );
    }

    return totalOrderPrice;
  }

  // Get a discount accorrding to the stock

  double get offerDiscout {
    double offerDiscount = 0;
    if (orderedItem.stock >= 1 && orderedItem.stock <= 4) {
      offerDiscount = 8.23;
    } else if (orderedItem.stock >= 5 && orderedItem.stock <= 6) {
      offerDiscount = 13.42;
    } else {
      offerDiscount = 21.45;
    }
    return offerDiscount;
  }
  // Increase or Decrease the stock

  void increaseStock() {
    orderedItem.stock++;
    notifyListeners();
  }

  void decreaseStock({required BuildContext context}) {
    if (orderedItem.foodType == "Sushi") {
      if (orderedItem.stock == 5) {
        ReusableMethods.showtoastification(message: "Minimum quantity is 5");
      } else {
        orderedItem.stock--;
      }
    } else {
      if (orderedItem.stock == 1) {
        ReusableMethods.showtoastification(
          message: "Minimum quiantity 1",
        );
      } else {
        orderedItem.stock--;
      }
    }

    notifyListeners();
  }

  // Get the final price after discount and the service

  double getTotalPriceAfterDiscountAndService({bool idDelivery = false}) {
    double finalPrice = 0;
    if (idDelivery) {
      finalPrice = getTotalOrderPrice + 11 - offerDiscout;
    } else {
      finalPrice = getTotalOrderPrice + 5 - offerDiscout;
    }
    finalPrice = double.parse(finalPrice.toStringAsFixed(2));

    return finalPrice;
  }
}
