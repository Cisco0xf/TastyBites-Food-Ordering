import 'package:flutter/material.dart';

enum Place {
  takeaway,
  restuarant,
  none,
}

class PlaceProvider extends ChangeNotifier {
  Place orderPlace = Place.takeaway;

  void placeSwitcher(Place place) {
    orderPlace = place;

    notifyListeners();
  }

  bool get isTakeaway => orderPlace == Place.takeaway;
}
/* 
class OrderPlaceProvider with ChangeNotifier {
  bool isTakeAway = true;
  bool isRasturent = false;

  void atResturent() {
    isTakeAway = false;
    isRasturent = true;
    notifyListeners();
  }

  void takeAway() {
    isTakeAway = true;
    isRasturent = false;
    notifyListeners();
  }
}
 */