import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/save_received_notifications/save_notifications.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/food_notification/empty_notifications.dart';
import 'package:provider/provider.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveNotificationsProvider>(
      builder: (context, receivedNotifications, child) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              color: SwitchColor.bgColor,
            ),
            child: receivedNotifications.isNotificationEmpty
                ? const EmptyNotificationsWidget()
                : ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .1,
                      top: 10,
                    ),
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: receivedNotifications.notification.length,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: borderRaduis(15),
                            color: const Color(0xFFF6F5F5),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF03AED2),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.notifications_active,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: context.screenWidth * .03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    receivedNotifications
                                        .notification[index].notificationTitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: context.screenWidth * .7,
                                    child: Text(
                                      receivedNotifications
                                          .notification[index].notificationBody,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: context.screenWidth * .7,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFEEF7FF),
                                            borderRadius: borderRaduis(10),
                                          ),
                                          child: Text(
                                            receivedNotifications
                                                .notification[index]
                                                .notificationTime,
                                            style: const TextStyle(
                                              fontFamily: FontFamily.mainFont,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
