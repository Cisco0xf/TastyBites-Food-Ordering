import 'package:flutter/material.dart';

class CurrentIndexProvider with ChangeNotifier {
  // Change the index of the showen categories
  int currentIndex = 0;

  void getNewIndex({required int newIndex}) {
    currentIndex = newIndex;

    notifyListeners();
  }

  // Change the index of the bottom app bar

  int currentContent = 0;

  void switchContent(int target) {
    currentContent = target - 1;
    notifyListeners();
  }
}
