import 'package:flutter/material.dart';

class ControllersManager {
  static TextEditingController? searchingController;
  //static TextEditingController? drinkSearchController;

  static void initSearhcingControllers() {
    searchingController = TextEditingController();
    // drinkSearchController = TextEditingController();
  }

  static void disposeControllers() {
    searchingController!.dispose();
    //drinkSearchController!.dispose();
  }
}
