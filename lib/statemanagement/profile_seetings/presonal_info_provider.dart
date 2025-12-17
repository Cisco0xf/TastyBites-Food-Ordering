// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/profile_seetings/save_last_bio.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/presentaition_layer/auth/push_to_auth/push_auth_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/update_password/new_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/personal_info_screen.dart';

class PersonalInfoProvider with ChangeNotifier {
  String get getCurrentUserName {
    String currentUserName =
        FirebaseAuth.instance.currentUser!.displayName as String;
    return currentUserName;
  }

  String get getCurrerentUserEmail {
    String? currentUserEmail =
        FirebaseAuth.instance.currentUser!.email as String;
    return currentUserEmail;
  }
  // Update userName

  //late TextEditingController updateDisplayNameController;

  bool isUpdateUserNameFocused = false;

  void focuseUnfocuse({
    required BuildContext context,
  }) {
    isUpdateUserNameFocused = !isUpdateUserNameFocused;
    if (isUpdateUserNameFocused) {
      showToastification(
        message: "You can update your username",
        type: ToastificationType.info,
      );
    } else {
      showToastification(
        message: "Feild has been disabled",
        type: ToastificationType.info,
      );
    }
    notifyListeners();
  }

  // Chick if user really update his info

  bool get chickUserUpdate {
    /* String? currentUserName =
        FirebaseAuth.instance.currentUser!.displayName as String; */
    //String userNameControllerText = updateDisplayNameController.text;
    // bool isUserNameUpdated = currentUserName == userNameControllerText;

    String userBIOController = bioController.text;

    bool isBIOUpdated = userBIOController == currentBIO;

    bool isUserUpdateAnyThing = /* isUserNameUpdated && */ isBIOUpdated;

    notifyListeners();

    return isUserUpdateAnyThing;
  }
/* 
  Future<void> updateUserName({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(
        updateDisplayNameController.text,
      );
      log(FirebaseAuth.instance.currentUser!.displayName.toString());
    } catch (error) {
      log("Error while update Username : $error");
    }
    notifyListeners();
  }
 */
  // Update user BIO

  late TextEditingController bioController;
  late String currentBIO;
  bool isbioFocused = false;

  void isbioFocuse({
    required BuildContext context,
  }) {
    isbioFocused = !isbioFocused;
    if (isbioFocused) {
      showToastification(
        message: "You can update your BIO",
        type: ToastificationType.info,
      );
    } else {
      showToastification(
        message: "Feild has been disabled",
        type: ToastificationType.info,
      );
    }
    notifyListeners();
  }

  void updateBIO() {
    currentBIO = bioController.text;
    putLastBioInDatabse();
    notifyListeners();
  }

  Future<void> putLastBioInDatabse() async {
    final SaveLastBio lastBio = SaveLastBio();
    await lastBio.putDataInDatabase(putedData: bioController.text);
  }

  Future<void> intializeBio() async {
    final SaveLastBio lastBio = SaveLastBio();
    String bioValue = await lastBio.getDataFromDatabase();
    currentBIO = bioValue;
    bioController = TextEditingController(
      text: currentBIO,
    );
    notifyListeners();
  }
/* 
  // Re-Authenticate to delete the account

  final TextEditingController deleteEmailController = TextEditingController();
  final TextEditingController deletePasswordController =
      TextEditingController();

  Future<void> reauthenticateToDeleteAccount({
    required BuildContext context,
  }) async {
    try {
      AuthCredential deleteAccountCredintional = EmailAuthProvider.credential(
        email: deleteEmailController.text,
        password: deletePasswordController.text,
      );
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
        deleteAccountCredintional,
      );
      log("Re-Authentication successfully");
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

  bool isObscure = true;
  Icon obscureIcon = const Icon(Icons.visibility);

  void unbObscure() {
    isObscure = !isObscure;
    if (isObscure) {
      obscureIcon = const Icon(Icons.visibility);
    } else {
      obscureIcon = const Icon(Icons.visibility_off);
    }
    notifyListeners();
  }

  // Delete user account

  Future<void> deleteUserAccount({
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const PushAuthScreen();
          },
        ),
        (route) {
          return false;
        },
      ).whenComplete(
        () {
          final CurrentIndexProvider currentIndex =
              Provider.of<CurrentIndexProvider>(
            context,
            listen: false,
          );
          currentIndex.switchContent(0);
        },
      );
    } on SocketException catch (_) {
      ReusableMethods.showAwesomDialog(
        context: context,
        description: "Please chick your internet connaction",
        title: "Internet",
      );
    } catch (error) {
      ReusableMethods.showAwesomDialog(
        context: context,
        description:
            "Something ges wrong while deleting accout please try later",
        title: "Error",
      );
      log("Error happens during delete user account : $error");
    }
    notifyListeners();
  } */
/* 
  // Re-set user password

  final TextEditingController resetEmailController = TextEditingController();
  final TextEditingController resetPasswordController = TextEditingController();

  void get clearReAuthControllers {
    resetEmailController.clear();
    resetPasswordController.clear();
  }

  Future<void> reAuthenticateToResetPassword({
    required BuildContext context,
  }) async {
    try {
      AuthCredential resetPasswordCredential = EmailAuthProvider.credential(
        email: resetEmailController.text,
        password: resetPasswordController.text,
      );
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
        resetPasswordCredential,
      );
      log("Re-Authenticated successfully");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const NewPasswordScreen();
          },
        ),
      );
      clearReAuthControllers;
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
    }
  }

  final TextEditingController enterNewPassword = TextEditingController();
  final TextEditingController enterConfirmPassword = TextEditingController();

  void get clearResetingPswControllers {
    enterNewPassword.clear();
    enterConfirmPassword.clear();
  }

  bool get isPasswordsMatches {
    String newPassword = enterNewPassword.text;
    String confirmPassword = enterConfirmPassword.text;
    bool isMtches = newPassword == confirmPassword;
    return isMtches;
  }

  Future<void> saveNewPassword({
    required BuildContext context,
  }) async {
    try {
      if (isPasswordsMatches) {
        String newPassword = enterNewPassword.text;
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
        await ReusableMethods.showAwesomDialog(
          context: context,
          description: "Your password has been updated",
          title: "Update password",
          dialogType: DialogType.success,
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return const PersonalInfoScreen();
            },
          ),
          (route) {
            return false;
          },
        );
        clearResetingPswControllers;
      } else {
        showToastification(
          message: "Passwrd not matches",
          type: ToastificationType.error,
        );
      }
    } on SocketException catch (_) {
      showToastification(
        message: "Please chick your internet connection",
      );
    }
  } */

  // Some User info

  Future<void> userInfo() async {
    FirebaseAuth.instance.currentUser!.displayName.toString();
    FirebaseAuth.instance.currentUser!.metadata.toString();
  }

  // Call needed methods in constructor

  PersonalInfoProvider() {
    /* updateDisplayNameController = TextEditingController(
      text: getCurrentUserName,
    ); */
    currentBIO = "Hello my name is $getCurrentUserName";

    intializeBio();
  }
}
