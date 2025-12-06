import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/presentaition_layer/auth/push_to_auth/push_auth_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shimmers/main_screen_shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.of(navigationKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return (FirebaseAuth.instance.currentUser != null &&
                      FirebaseAuth.instance.currentUser!.emailVerified)
                  ? const MainScreenShimmer()
                  : const PushAuthScreen();
            },
          ),
        );
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
    
    InitDB.initDB();

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
            SizedBox(
              height: context.screenHeight * .1,
            ),
            SizedBox(
              width: context.screenWidth * .65,
              height: context.screenHeight * .35,
              child: Image.asset(
                "asstes/images/app_images/splash_screen-images/food_logo_large.png",
                fit: BoxFit.contain,
              ),
            ),
            const CircularProgressIndicator(),
            SizedBox(
              height: context.screenHeight * .27,
            ),
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
