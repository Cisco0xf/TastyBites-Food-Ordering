import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/delete_user_account/confirm_user_deletion.dart';

class DeleteUserAccountScreen extends StatelessWidget {
  const DeleteUserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: context.screenHeight * .05,
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.orange,
                  size: 35,
                ),
              ),
              SizedBox(
                width: context.screenWidth * .15,
              ),
              const Text(
                "Delete account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.mainFont,
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.screenHeight * .03,
          ),
          const Text(
            "Are you sure you want to delete your account ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "This can not be undone.",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFDD5746),
            ),
          ),
          SizedBox(
            height: context.screenHeight * .02,
          ),
          const DeleteInfoWidget(
            title: "All workout data and history will no longer be accessible.",
            leadding: Icons.trending_up,
          ),
          SizedBox(
            height: context.screenHeight * .06,
          ),
          const DeleteInfoWidget(
            title: "Your public profile will be permanently removed.",
            leadding: Icons.person_2_outlined,
          ),
          SizedBox(
            height: context.screenHeight * .06,
          ),
          const DeleteInfoWidget(
            title: "All your receipts will no longer exist.",
            leadding: Icons.receipt,
          ),
          SizedBox(
            height: context.screenHeight * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: context.screenWidth * .4,
                height: context.screenHeight * .07,
                child: MaterialButton(
                  onPressed: () {
                    /* Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const AnimationLogInWidget();
                        },
                      ),
                    ); */
                  },
                  color: const Color(0xFFDDDDDD),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRaduis(25),
                  ),
                  child: const Text("CANCLE"),
                ),
              ),
              SizedBox(
                width: context.screenWidth * .4,
                height: context.screenHeight * .07,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ConfirmUserScreen();
                        },
                      ),
                    );
                  },
                  color: const Color(0xFFDDDDDD),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRaduis(25),
                  ),
                  child: const Text(
                    "Delete Now",
                    style: TextStyle(
                      color: Color(0xFFD24545),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DeleteInfoWidget extends StatelessWidget {
  const DeleteInfoWidget({
    super.key,
    required this.leadding,
    required this.title,
  });

  final String title;
  final IconData leadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            leadding,
            size: 40,
            color: const Color(0xFFA9A9A9),
          ),
          SizedBox(
            width: context.screenWidth * .05,
          ),
          SizedBox(
            width: context.screenWidth * .78,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: FontFamily.mainFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
