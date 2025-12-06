import 'package:flutter/material.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/enums.dart';

BorderRadius borderRaduis(double raduis, {Side side = Side.all}) {
  final Map<Side, BorderRadius> raduisMap = {
    Side.all: BorderRadius.circular(raduis),
    Side.top: BorderRadius.vertical(top: Radius.circular(raduis)),
    Side.left: BorderRadius.horizontal(left: Radius.circular(raduis)),
    Side.bottom: BorderRadius.vertical(bottom: Radius.circular(raduis)),
    Side.right: BorderRadius.horizontal(right: Radius.circular(raduis)),
  };

  return raduisMap[side]!;
}

EdgeInsetsGeometry padding(double padding, {From from = From.all}) {
  final Map<From, EdgeInsets> paddingMap = {
    From.all: EdgeInsets.all(padding),
    From.vertical: EdgeInsets.symmetric(vertical: padding),
    From.horizontal: EdgeInsets.symmetric(horizontal: padding),
  };

  return paddingMap[from]!;
}

class Clicker extends StatelessWidget {
  const Clicker({
    super.key,
    this.isCircular = false,
    required this.onClick,
    this.innerPadding = 7.0,
    this.raduis = 10.0,
    required this.child,
  });
  final double raduis;
  final double innerPadding;
  final void Function() onClick;
  final bool isCircular;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        borderRadius: isCircular ? null : borderRaduis(raduis),
        customBorder: isCircular ? const CircleBorder() : null,
        child: Padding(
          padding: padding(innerPadding),
          child: child,
        ),
      ),
    );
  }
}

void pushTo(Widget target, {Push type = Push.push}) {
  final BuildContext context = navigationKey.currentContext as BuildContext;
  switch (type) {
    case Push.clear:
      {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            return target;
          },
        ), (root) => true);

        return;
      }
    case Push.push:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return target;
          },
        ));
        return;
      }
    case Push.replace:
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return target;
          },
        ));
        return;
      }
    default:
      {}
  }
}

class CheckDivider extends StatelessWidget {
  const CheckDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      thickness: 2,
      endIndent: 20,
      indent: 20,
    );
  }
}
