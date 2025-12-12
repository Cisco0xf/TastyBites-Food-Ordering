// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shimmers/main_screen_shimmer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AuthenticationProvider with ChangeNotifier {
  // Chick if user log in or not
  Future<void> get userLogin async {
    bool isUserLoggedin = FirebaseAuth.instance.currentUser == null;
    bool isEmailVerified = !FirebaseAuth.instance.currentUser!.emailVerified;
    log("Befor : ${FirebaseAuth.instance.currentUser!.emailVerified}");
    log("Befor : ${FirebaseAuth.instance.currentUser!.emailVerified}");

    if (isUserLoggedin && isEmailVerified) {
      log("User Is not login");
    } else {
      log(
        "User Is log in successfully",
        time: DateTime.now(),
      );
    }
    notifyListeners();
  }

  AuthenticationProvider() {
    //userLogin;
  }

  // Create account TextEditingControllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameControler = TextEditingController();
  final TextEditingController _passwordControlle = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get userNameControler => _userNameControler;
  TextEditingController get passwordController => _passwordControlle;
  TextEditingController get reEnterPasswordController =>
      _reEnterPasswordController;

  // Clear controllers

  void get clearCreatingAccountControllers {
    emailController.clear();
    userNameControler.clear();
    passwordController.clear();
    reEnterPasswordController.clear();
  }

  // Chick if Controllers is Ok

  void chickIsEverythingOk() {
    log("User Name : ${userNameControler.text}");
    log("Email : ${emailController.text}");
    log("Password : ${passwordController.text}");
    log("Re-Enter Password : ${reEnterPasswordController.text}");
    notifyListeners();
  }

  // Is Password visible

  Icon paswrdIcon = const Icon(Icons.visibility);
  bool isPaswrdObscured = true;
  Icon rePaswrdIcon = const Icon(Icons.visibility);
  bool isRePaswrdObscured = true;

  void get showPassword {
    isPaswrdObscured = !isPaswrdObscured;

    if (isPaswrdObscured) {
      paswrdIcon = const Icon(Icons.visibility);
    } else {
      paswrdIcon = const Icon(Icons.visibility_off);
    }
    notifyListeners();
  }

  void get showErEnterPassword {
    isRePaswrdObscured = !isRePaswrdObscured;

    if (isRePaswrdObscured) {
      rePaswrdIcon = const Icon(Icons.visibility);
    } else {
      rePaswrdIcon = const Icon(Icons.visibility_off);
    }
    notifyListeners();
  }

  bool get isPasswordAndReenterPasswordMatchs {
    bool isPaswrdNotEmpty = passwordController.text.isNotEmpty;
    bool isreEnterPasswordNotEmpty = reEnterPasswordController.text.isNotEmpty;
    bool isMatch = passwordController.text == reEnterPasswordController.text &&
        isreEnterPasswordNotEmpty &&
        isPaswrdNotEmpty;
    return isMatch;
  }

  // Create Account authantication

  Color borderColor = Colors.transparent;

  void errorBorder() {
    if (isPasswordAndReenterPasswordMatchs) {
      borderColor = Colors.transparent;
    } else {
      borderColor = Colors.red;
    }
    notifyListeners();
  }

  Future<void> createAccountWithEmailAndPssword({
    required BuildContext context,
  }) async {
    try {
      if (isPasswordAndReenterPasswordMatchs) {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Save User name

        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(userNameControler.text);

        // Send me a verification message

        sentVerificationMessage();

        // Push me to Log in page

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const LogInScreen();
            },
          ),
          (route) {
            return false;
          },
        );

        log("User has been Signed In with Email : ${emailController.text}");
        log("Password : ${passwordController.text}");
        clearCreatingAccountControllers;
      } else {
        ReusableMethods.showtoastification(
          message: "Password is not matching",
          type: ToastificationType.error,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ReusableMethods.showAwesomDialog(
          context: context,
          description: "The password provided is too weak.",
          dialogType: DialogType.info,
          title: "Weak password",
        );
      } else if (e.code == 'email-already-in-use') {
        ReusableMethods.showAwesomDialog(
          context: context,
          description: "There is an account created with this email.",
          dialogType: DialogType.info,
          title: "Email Exist",
        );
      }
    } on SocketException catch (_) {
      ReusableMethods.showAwesomDialog(
        context: context,
        description: "Please chick your internet conection",
        title: "Internet connection",
      );
    }
  }

  // Sign in Authentication

  // Login controllers

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  TextEditingController get loginEmailController => _loginEmailController;
  TextEditingController get loginPasswordController => _loginPasswordController;

  void get clearSiningInControllers {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  // Is password visible

  bool isObscure = true;
  Icon obscureIcon = const Icon(Icons.visibility);

  void get showLoginPassword {
    isObscure = !isObscure;
    if (isObscure) {
      obscureIcon = const Icon(Icons.visibility);
    } else {
      obscureIcon = const Icon(Icons.visibility_off);
    }
    notifyListeners();
  }

  // Sign in with user email && password

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );

      log("Is email verified : ${FirebaseAuth.instance.currentUser!.emailVerified}");
      // Reload Firebase from app
      await FirebaseAuth.instance.currentUser!.reload();

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        log("Is email verified : ${FirebaseAuth.instance.currentUser!.emailVerified}");

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const MainScreenShimmer();
            },
          ),
          (route) {
            return false;
          },
        );
        clearSiningInControllers;
      } else {
        log("Is email verified : ${FirebaseAuth.instance.currentUser!.emailVerified}");
        ReusableMethods.showAwesomDialog(
          context: context,
          description: "Please verify your email",
          title: "Verification !!",
        );
      }
      chickLogIn();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log("Error : ${e.code}");
        ReusableMethods.showAwesomDialog(
          context: context,
          description: "No user found for that email.",
          title: "Not Found",
        );
      } else if (e.code == 'wrong-password') {
        log("Error : ${e.code}");
        ReusableMethods.showAwesomDialog(
          context: context,
          description: "Wrong password provided for that user.",
          title: "Wrong password",
        );
        log("Wrong Password");
      }
    } on SocketException catch (_) {
      ReusableMethods.showAwesomDialog(
        context: context,
        description: "Please chick your internet conection",
        title: "Internet connection",
      );
    }
    notifyListeners();
  }

  void chickLogIn() {
    log("User has been Loged in with Email :${loginEmailController.text}");
    log("Password :${loginPasswordController.text}");
    notifyListeners();
  }
  // Send me a verification email

  Future<void> sentVerificationMessage() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();

    notifyListeners();
  }

  // Forget password send me a reset link

  final TextEditingController _resetPasswordConroller = TextEditingController();

  TextEditingController get resetPasswordController => _resetPasswordConroller;

  Future<void> sentResetPasswordLink() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: resetPasswordController.text,
    );
  }

  // Log in with google account

  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const MainScreenShimmer();
          },
        ),
        (route) {
          return false;
        },
      );
    } else {}
  }

  // Sign out

  Future<void> signOut({
    required BuildContext context,
  }) async {
    try {
      // Sign out from the email
      bool isSignIn = FirebaseAuth.instance.currentUser != null;
      // Sign out from google account
      bool account = await GoogleSignIn().isSignedIn();

      if (isSignIn) {
        // Sign out from the email
        log("User has been Signed Out");

        await FirebaseAuth.instance.signOut();
        CurrentIndexProvider currentContent = Provider.of<CurrentIndexProvider>(
          context,
          listen: false,
        );
        currentContent.switchContent(0);
      } else if (account) {
        // Sign out from google account
        GoogleSignIn signOutFromGoogle = GoogleSignIn();
        await signOutFromGoogle.disconnect();
        CurrentIndexProvider currentContent = Provider.of<CurrentIndexProvider>(
          context,
          listen: false,
        );
        currentContent.switchContent(0);
      } else {
        log("Can not Log out");
      }
    } catch (error) {
      log("Log out Error :$error");
    }

    notifyListeners();
  }
}
