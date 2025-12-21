import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/auth/push_to_auth/push_auth_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shimmers/main_screen_shimmer.dart';
import 'package:foodapp/statemanagement/theming/theme_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SaveTheme.initThemeStateFromDb();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );

    Future.delayed(
      const Duration(seconds: 3),
      () {
        final User? user = FirebaseAuth.instance.currentUser;

        final bool goodToGo = (user != null && user.emailVerified);

        final Widget target =
            goodToGo ? const MainScreenShimmer() : const PushAuthScreen();

        pushTo(target, type: Push.replace);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    //  InitDB.initDB();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF2C3333),
              Color(0xFF3a546e),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Gap(hRatio: 0.1),
            SizedBox.square(
              dimension: context.screenHeight * 0.35,
              child: Image.asset(
                "asstes/images/app_images/splash_screen-images/food_logo_large.png",
                fit: BoxFit.contain,
              ),
            ),
            LoadingAnimationWidget.fourRotatingDots(
              color: SwitchColor.primaryO,
              size: 35.0,
            ),
            const Gap(hRatio: 0.27),
            const Text(
              "TastyBites",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
