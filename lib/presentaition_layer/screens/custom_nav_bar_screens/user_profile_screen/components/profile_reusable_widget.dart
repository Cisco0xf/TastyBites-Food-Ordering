import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/style.dart';

class ProfileReusableWidget extends StatelessWidget {
  const ProfileReusableWidget({
    super.key,
    required this.title,
    required this.trailing,
    required this.targetWidget,
  });
  final String title;
  final Icon trailing;
  final Widget targetWidget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRaduis(10.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return targetWidget;
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: context.isLight
                        ? Colors.white
                        : Colors.black45.withOpacity(0.5),
                    child: trailing,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: AppTextStyles.profileWidgetTextStyle(
                      context: context,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
