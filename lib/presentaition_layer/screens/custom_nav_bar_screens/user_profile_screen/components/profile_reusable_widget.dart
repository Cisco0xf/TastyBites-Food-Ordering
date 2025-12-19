import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/style.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
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
        onTap: () => pushTo(targetWidget),
        child: Padding(
          padding: padding(8.0),
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
                  const Gap(width: 20.0),
                  Text(
                    title,
                    style:
                        AppTextStyles.profileWidgetTextStyle(context: context),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
