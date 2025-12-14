import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/auth/components/send_vrification_dialog.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shimmers/main_screen_shimmer.dart';
import 'package:toastification/toastification.dart';

class AuthControllers {
  // Create New Account Controllers
  static TextEditingController? username;
  static TextEditingController? emailController;
  static TextEditingController? pswController;
  static TextEditingController? rePwsController;

  static void initCreateAccoutnControllers() {
    username = TextEditingController();
    emailController = TextEditingController();
    pswController = TextEditingController();
    rePwsController = TextEditingController();
  }

  static void disposeCreateAccoutnControllers() {
    username!.dispose();
    emailController!.dispose();
    pswController!.dispose();
    rePwsController!.dispose();
  }

  // Log in controllers

  static TextEditingController? logEmailController;
  static TextEditingController? logPwsController;

  static void initLogInControllers() {
    logEmailController = TextEditingController();
    logPwsController = TextEditingController();
  }

  static void disposeLogInControllers() {
    logEmailController!.dispose();
    logPwsController!.dispose();
  }

  // Reset Paassword Controllers

  static TextEditingController? resetPassworsEmail;

  static void initResetPwsEmailController() {
    resetPassworsEmail = TextEditingController();
  }

  static void diposeResetPwsEmailController() {
    resetPassworsEmail!.dispose();
  }
}

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create new account

  String get _createEmail => AuthControllers.emailController!.text.trim();
  String get _createuserName => AuthControllers.username!.text.trim();
  String get _createPws => AuthControllers.pswController!.text.trim();
  String get _createRePws => AuthControllers.rePwsController!.text.trim();

  bool hasFullData() {
    final bool hasUsername = _createuserName.isNotEmpty;
    final bool hasEmail = _createEmail.isNotEmpty;
    final bool hasPws = _createPws.isNotEmpty;

    final bool isGoodToGo = hasUsername && hasPws && hasEmail;

    return isGoodToGo;
  }

  bool passwordMatches() => _createPws == _createRePws;

  Future<void> _updateCurrnetUsername() async =>
      await _auth.currentUser!.updateDisplayName(_createuserName);

  Future<void> _sendVerificationEmail() async =>
      _auth.currentUser!.sendEmailVerification();

  Future<void> createNewAccountWithEmailAndPassword() async {
    try {
      // Check that user entires

      if (!hasFullData()) {
        showToastification(message: "Please enter the required data");
        return;
      }

      if (!passwordMatches()) {
        showToastification(message: "Password confirmation is not match");
        return;
      }

      // Create new Account
      await _auth.createUserWithEmailAndPassword(
        email: _createEmail,
        password: _createPws,
      );

      await _updateCurrnetUsername();

      // Send a vrification link
      await _sendVerificationEmail().whenComplete(() {
        showToastification(
          message: "We have send you a verification message, check you email",
          type: ToastificationType.success,
        );
      });

      // Push to log in
      pushTo(const LogInScreen(), type: Push.clear);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        showToastification(message: "Please enter storing password");
        return;
      }

      if (e.code == "email-already-in-use") {
        showToastification(message: "Inserted Email is already used");
        return;
      }
      showToastification(message: "Something went wrong, try again later");
    } on SocketException {
      showToastification(message: "Please check your internet connect");
    } catch (error) {
      showToastification(message: "Something went wrong, try again later");
      Log.error("Auth Error => $error");
    }
  }

  // Log in with current account

  String get _loginEmail => AuthControllers.logEmailController!.text.trim();
  String get _logPws => AuthControllers.logPwsController!.text.trim();

  bool logHasFullData() {
    final bool hasEmail = _loginEmail.isNotEmpty;
    final bool hasPws = _logPws.isNotEmpty;
    final isOk = hasEmail && hasPws;

    return isOk;
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      if (!logHasFullData()) {
        showToastification(message: "Please enter the email and Password");
        return;
      }

      final UserCredential user = await _auth.signInWithEmailAndPassword(
        email: _loginEmail,
        password: _logPws,
      );

      final bool isVerified = user.user!.emailVerified;

      if (!isVerified) {
        await sendVrificationDialog(onSend: () async {
          await _sendVerificationEmail();
          popScreen();
        });

        return;
      }

      pushTo(const MainScreenShimmer(), type: Push.clear);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showToastification(message: "User is not found");
        return;
      }

      if (e.code == "wrong-password") {
        showToastification(
          message: "Please check the password",
          type: ToastificationType.error,
        );

        return;
      }
      
      showToastification(message: "Something went wrong, try again later");
    } catch (error) {
      showToastification(message: "Something went wrong, try again later");
      Log.error("Log In Error => $error");
    }
  }

  // Reset the account password

  // Sign in with Google

  // Delete account

  // Sign out
}
