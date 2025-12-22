import 'package:flutter/material.dart';

class ControllersManager {
  static TextEditingController? searchingController;

  static void initSearhcingControllers() {
    searchingController = TextEditingController();
  }

  static void disposeControllers() {
    searchingController!.dispose();
  }
}
