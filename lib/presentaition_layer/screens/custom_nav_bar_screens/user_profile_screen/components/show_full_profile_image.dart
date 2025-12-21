import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/assets.dart';


class Profile extends StatelessWidget {
  const Profile({super.key, required this.raduis});

  final double raduis;

  @override
  Widget build(BuildContext context) {
    return Clicker(
      onClick: () async {
        await showFullImage(Assets.profileImage);
      },
      isCircular: true,
      innerPadding: 0.0,
      child: CircleAvatar(
          radius: raduis,
          backgroundColor: Colors.transparent,
          backgroundImage: const AssetImage(Assets.profileImage)),
    );
  }
}

Future<void> showFullImage(String targetImage) async {
  final BuildContext context = navigationKey.currentContext as BuildContext;

  await showDialog(
    context: context,
    builder: (context) {
      return UserFullImage(targetImage: targetImage);
    },
  );
}

class UserFullImage extends StatelessWidget {
  const UserFullImage({super.key, required this.targetImage});

  final String targetImage;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: InteractiveViewer(
              child: Padding(
                padding: padding(10.0),
                child: Image.asset(targetImage),
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                popScreen();
              },
            ),
          ),
          Positioned(
            top: 100.0,
            right: 20.0,
            child: ClipRect(
              child: ClipRRect(
                borderRadius: borderRaduis(7.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRaduis(7.0),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Clicker(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
