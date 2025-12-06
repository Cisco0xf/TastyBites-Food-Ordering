import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ShowProfileImageWidget extends StatelessWidget {
  const ShowProfileImageWidget({
    super.key,
    required this.child,
    required this.imagePath,
  });
  final Widget child;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: borderRaduis(10),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ShowFullImageWidget(
                          imagePath: imagePath,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRaduis(10),
                  ),
                  width: context.screenWidth * .95,
                  height: context.screenHeight * .3,
                  child: Hero(
                    tag: "profile_image",
                    child: ClipRRect(
                      borderRadius: borderRaduis(7),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: child,
    );
  }
}

class ShowFullImageWidget extends StatefulWidget {
  const ShowFullImageWidget({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  State<ShowFullImageWidget> createState() => _ShowFullImageWidgetState();
}

class _ShowFullImageWidgetState extends State<ShowFullImageWidget>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  late Animation<Matrix4> matrixAnimation;
  @override
  void initState() {
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    )
      ..addListener(
        () {
          _transformationController.value = matrixAnimation.value;
        },
      )
      ..addStatusListener(
        (AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            log("Animation State done");
          }
        },
      );
    super.initState();

    daimentionals(context: context);
  }

  void resetAnimation() {
    matrixAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward(from: 0);
  }

  void zoomImage() {
    matrixAnimation = Matrix4Tween(
      begin: Matrix4.identity(),
      end: Matrix4(
        2,
        0,
        0,
        0,
        0,
        2,
        0,
        0,
        0,
        0,
        2,
        0,
        0,
        0,
        0,
        1,
      ),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward(from: 1.0);
  }

  bool get _isZoomed {
    bool isZoomed = _transformationController.value == Matrix4.identity();
    return isZoomed;
  }

  double minScale = 1;
  double maxScale = 5;

  late double top;
  late double left;
  late double? width;
  late double? height;

  void daimentionals({required BuildContext context}) {
    setState(() {
      top = 200;
      left = 0;

      width = null;
      height = null;
    });
  }

  late RenderBox imageBox;
  late Offset imageOffset;

  void setRenderValue({required BuildContext context}) {
    setState(() {
      imageBox = context.findRenderObject()! as RenderBox;
      imageOffset = imageBox.localToGlobal(Offset.zero);
    });
    setState(() {
      top = imageOffset.dy;
      left = imageOffset.dx;

      width = imageBox.size.width;
      height = imageBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    //daimentionals(context: context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: top,
            width: width,
            height: height,
            left: left,
            //right: right,
            child: GestureDetector(
              onDoubleTap: () {
                if (_isZoomed) {
                  zoomImage();
                } else {
                  resetAnimation();
                }

                log("Transformation Value :\n${_transformationController.value}");
                log("MatrixController Value:\n ${matrixAnimation.value}");
              },
              child: InteractiveViewer(
                transformationController: _transformationController,
                panEnabled: false,
                clipBehavior: Clip.none,
                onInteractionStart: (details) {
                  if (details.pointerCount > 1) {
                    setRenderValue(context: context);
                  }
                },
                minScale: minScale,
                maxScale: maxScale,
                child: Hero(
                  tag: "profile_image",
                  child: Image.asset(
                    widget.imagePath,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: context.screenHeight * .05,
            left: 10,
            right: 20,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.orange,
                    size: 35,
                  ),
                ),
                Consumer<PersonalInfoProvider>(
                  builder: (context, userName, child) {
                    return Text(
                      userName.getCurrentUserName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: FontFamily.mainFont,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
