import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/save_received_notifications/notifications_model.dart';
import 'package:intl/intl.dart';

class SaveNotificationsProvider with ChangeNotifier {
  List<ReceivedNotificationsModel> notification =
      <ReceivedNotificationsModel>[];
  void addNewNotification({
    required ReceivedNotificationsModel newNotification,
  }) {
    notification.add(newNotification);
    notifyListeners();
  }

  bool get isNotificationEmpty {
    bool isEmpty = notification.isEmpty;
    return isEmpty;
  }

  String get getCurrentDateTime {
    String dateTime = DateFormat("MMM d, hh:mm aaa").format(
      DateTime.now(),
    );
    return dateTime;
  }
}
