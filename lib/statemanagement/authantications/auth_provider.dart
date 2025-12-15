import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/auth/components/send_vrification_dialog.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/presentaition_layer/auth/push_to_auth/push_auth_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shimmers/main_screen_shimmer.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class FireAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Handel loading

  bool isLoading = false;

  void _switchLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

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

  Future<void> _sendVerificationEmail() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        Log.error("User is Null");

        return;
      }

      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Log.error("FirebaseAuthException => ${e.code}");
    } on SocketException {
      showToastification(message: "Check Internet connection");
    } catch (error) {
      Log.error("Error send Vrification => $error");
    }
  }

  Future<void> createNewAccountWithEmailAndPassword() async {
    _switchLoading();
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
    } finally {
      _switchLoading();
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
    _switchLoading();
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
    } finally {
      _switchLoading();
    }
  }

  // Send Reset Password Email

  String get _resetPws => AuthControllers.resetPassworsEmail!.text.trim();

  bool hasResetEmail() => _resetPws.isNotEmpty;

  Future<void> sendResetPasswordEmail() async {
    _switchLoading();
    try {
      if (!hasResetEmail()) {
        showToastification(message: "Please insert the email");
        return;
      }

      await _auth.sendPasswordResetEmail(email: _resetPws).whenComplete(() {
        showToastification(message: "Email has been sent, check you inbox");
      });
    } on SocketException {
      showToastification(message: "Please check internet connection");
    } catch (error) {
      Log.error("Send Reset Error => $error");
    } finally {
      _switchLoading();
    }
  }

  // Sign in with Google

  Future<void> signInWithGoogleAccount() async {
    try {
      final GoogleSignIn google = GoogleSignIn();

      final GoogleSignInAccount? account = await google.signIn();

      final bool hasUser = account != null;

      if (!hasUser) {
        showToastification(message: "Something went wrong, try again later");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await account.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential).whenComplete(() {
        pushTo(const MainScreenShimmer(), type: Push.clear);
        Log.log("Signned in with google successfully");
      });
    } on SocketException {
      showToastification(message: "Please check ibternet connection");
    } catch (error) {
      Log.error("Google Sign In Error => $error");
    }
  }

  // Sign out

  void _resetAppForSignOut() {
    final BuildContext context = navigationKey.currentContext as BuildContext;
    context.read<CurrentIndexProvider>().switchContent(0);
    pushTo(const PushAuthScreen(), type: Push.clear);
  }

  Future<void> signOutFromApp() async {
    _switchLoading();

    final GoogleSignIn google = GoogleSignIn();
    final bool isGoogle = await google.isSignedIn();

    final bool isAccount = _auth.currentUser != null;

    try {
      if (isGoogle) {
        await google.disconnect();
        _resetAppForSignOut();

        return;
      }

      if (isAccount) {
        await _auth.signOut();
        _resetAppForSignOut();

        return;
      }

      Log.log("Can not found SignIn Value", color: LColor.white);
    } on FirebaseAuthException catch (error) {
      Log.error("FirebaseAuthExciption = > ${error.code}");
    } on SocketException {
      showToastification(message: "Chatck you internet");
    } catch (error) {
      Log.error("Catch error from signOut => $error");
    } finally {
      _switchLoading();
    }
  }
}
