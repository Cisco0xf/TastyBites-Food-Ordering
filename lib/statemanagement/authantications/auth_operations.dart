import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/auth/push_to_auth/push_auth_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/personal_info_screen.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/cloud_firestore/manage_metadata.dart';
import 'package:toastification/toastification.dart';

class AuthOperations extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isOperating = false;

  void _switchOperationState() {
    isOperating = !isOperating;
    notifyListeners();
  }

  bool get _hasUser => _auth.currentUser != null;
  // Re-Authenticate the current Account for => Update Password && Delete Account

  String get _reauthEmail => AuthControllers.reauthEmail!.text.trim();
  String get _reauthPws => AuthControllers.reauthPws!.text.trim();

  bool _reauthHasFullData() {
    final bool hasEmail = _reauthEmail.isNotEmpty;
    final bool hasPws = _reauthPws.isNotEmpty;

    final bool hasData = hasEmail && hasPws;

    return hasData;
  }

  Future<void> reauthenticateCurrentUserForCriticalAction({
    required void Function() actionAfterReauthenticate,
  }) async {
    _switchOperationState();
    if (!_reauthHasFullData()) {
      showToastification(message: "Please insert required data");
      return;
    }

    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: _reauthEmail,
        password: _reauthPws,
      );

      final User? user = _auth.currentUser;

      if (!_hasUser) {
        Log.log("User is NULL", color: LColor.white);
        return;
      }

      await user!.reauthenticateWithCredential(credential);

      actionAfterReauthenticate();
    } on SocketException {
      showToastification(message: "Please check your internet.");
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

      showToastification(message: "Something went wrong.");
    } catch (error) {
      showToastification(message: "Something went wrong.");
    } finally {
      _switchOperationState();
    }
  }

  // Delete current Account

  Future<void> deleteCurrentUser() async {
    _switchOperationState();
    try {
      final User? user = _auth.currentUser;

      if (!_hasUser) {
        Log.log("User is NULL", color: LColor.white);
        return;
      }

      await user!.delete();

      await ManageUserMetadata().deleteUserFromDatabase();

      pushTo(const PushAuthScreen(), type: Push.clear);
    } on FirebaseAuthException catch (error) {
      showToastification(message: "Something went wrong.");
      Log.error("FirebaseAuthException => ${error.code}");
    } on SocketException {
      showToastification(message: "Please check your internet.");
    } catch (error) {
      showToastification(message: "Something went wrong.");
      Log.error('Deletion Erro => $error');
    } finally {
      _switchOperationState();
    }
  }

  // Update current password

  String get _updatePws => AuthControllers.updatePws!.text.trim();
  String get _reUpdatePws => AuthControllers.reupdatePws!.text.trim();

  bool hasFullPws() {
    final bool hasPws = _updatePws.isNotEmpty;
    final bool hasrePws = _reUpdatePws.isNotEmpty;

    final bool hasData = hasPws && hasrePws;
    return hasData;
  }

  bool matchedPws() => _updatePws == _reUpdatePws;

  Future<void> updateCurrentUserPawwsord() async {
    if (!hasFullPws()) {
      showToastification(message: "Please insert full data");
      return;
    }

    if (!matchedPws()) {
      showToastification(message: "Password comfimation is not match");

      return;
    }

    _switchOperationState();

    try {
      if (!_hasUser) {
        Log.log("User is NULL", color: LColor.white);
        return;
      }

      await _auth.currentUser!.updatePassword(_updatePws);

      pushTo(const PersonalInfoScreen(), type: Push.clear);

      Log.log("Password has been updated successfully");
    } on FirebaseAuthException catch (error) {
      showToastification(message: "Something went wrong.");
      Log.error("FirebaseAuthException => ${error.code}");
    } on SocketException {
      showToastification(message: "Please check your internet.");
    } catch (error) {
      showToastification(message: "Something went wrong.");
      Log.error('Deletion Erro => $error');
    } finally {
      _switchOperationState();
    }
  }

  // Update Current Username

  String get _usernameUpdate => AuthControllers.updateUsername!.text.trim();

  bool hasUsername() => _usernameUpdate.isNotEmpty;

  bool hasChange() {
    final String oldUsername = _auth.currentUser!.displayName ?? "";

    final bool hasUpdate = oldUsername != _usernameUpdate;

    return hasUpdate;
  }

  Future<void> updateCurrentUsername() async {
    _switchOperationState();
    try {
      if (!hasUsername()) {
        showToastification(message: "Username cannot be empty");

        return;
      }

      if (!hasChange()) {
        return;
      }

      await _auth.currentUser!.updateDisplayName(_usernameUpdate);

      await ManageUserMetadata().updateUsername();

      showToastification(
        message: "Username has been updated succcessfully",
        type: ToastificationType.success,
      );

      Log.log("Username updated successfully");
    } catch (error) {
      Log.error("Username Update Error => $error");
    } finally {
      _switchOperationState();
    }
  }
}
