import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/cloud_firestore/manage_metadata.dart';

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

  // Operations Controller

  static TextEditingController? updatePws;
  static TextEditingController? reupdatePws;

  static void initUpdatePwsController() {
    updatePws = TextEditingController();
    reupdatePws = TextEditingController();
  }

  static void disposeUpdatePasswordControllers() {
    updatePws!.dispose();
    reupdatePws!.dispose();
  }

  // Re-Authenticate

  static TextEditingController? reauthEmail;
  static TextEditingController? reauthPws;

  static void initReauthControllers() {
    reauthEmail = TextEditingController();
    reauthPws = TextEditingController();
  }

  static void disposeReauthControllers() {
    reauthEmail!.dispose();
    reauthPws!.dispose();
  }

  // Update username controller
  static TextEditingController? updateUsername;
  static TextEditingController? bioController;

  static void initMetaContorllers() {
    final String currentUser =
        FirebaseAuth.instance.currentUser!.displayName ?? "USERNAME";
    updateUsername = TextEditingController(text: currentUser);

    final String bio = ManageUserMetadata.sessionBIO;
    bioController = TextEditingController(text: bio);
  }

  static void disposeMetaControllers() {
    updateUsername!.dispose();
    bioController!.dispose();
  }

  // Update User BIO text
}
