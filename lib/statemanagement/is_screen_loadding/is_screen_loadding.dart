/* import 'dart:async';

import 'package:flutter/material.dart';

class IsScreenLoadding with ChangeNotifier {
  bool isLoadding = true;

  Future<void> waitScreenToLoadd({
    int seconds = 0,
    int millisconds = 0,
  }) async {
    Timer(
      Duration(
        seconds: seconds,
        milliseconds: millisconds,
      ),
      () {
        isLoadding = false;
        notifyListeners();
      },
    );
    /*
    Future.delayed(
      Duration(
        seconds: seconds,
        milliseconds: millisconds,
      ),
      () {
        isLoadding = false;
        notifyListeners();
      },
    );*/
  }
}
 */