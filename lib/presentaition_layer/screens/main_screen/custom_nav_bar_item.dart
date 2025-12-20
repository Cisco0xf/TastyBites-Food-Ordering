import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/presentaition_layer/screens/main_screen/main_screen.dart';

class CustomNavigationBarItem extends StatelessWidget {
  const CustomNavigationBarItem({
    super.key,
    required this.icon,
    required this.onSelect,
    required this.isSelected,
  });

  final NavBarIconModel icon;
  final void Function() onSelect;
  final bool isSelected;

  Color? get _color =>
      isSelected ? SwitchColor.primaryO.withOpacity(0.7) : null;

  Icon get _icon => isSelected
      ? Icon(
          icon.selectedIcon,
          key: ValueKey(icon.selectedIcon),
        )
      : Icon(
          icon.icon,
          key: ValueKey(icon.key),
        );

  @override
  Widget build(BuildContext context) {
    return Clicker(
      onClick: onSelect,
      innerPadding: 5.0,
      raduis: 20.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: context.screenWidth * .17,
        padding: padding(3.0),
        decoration: BoxDecoration(
          borderRadius: borderRaduis(20.0),
          color: _color,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: _icon,
        ),
      ),
    );
  }
}
