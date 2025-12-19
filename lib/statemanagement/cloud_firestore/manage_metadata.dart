import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/cloud_firestore/collections.dart';
import 'package:foodapp/statemanagement/cloud_firestore/sync_locale_with_cloud.dart';
import 'package:toastification/toastification.dart';

class ManageUserMetadata extends ChangeNotifier {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //================ METADATA ================

  String get _usersCollection => Collections.USER_COLLECTION;

  String get _userId => _auth.currentUser!.uid;

  // Add new user

  DocumentReference get _userDoc {
    final DocumentReference user = _firestore
        .collection(
          _usersCollection,
        )
        .doc(_userId);
    return user;
  }

  Future<void> addNewManageUserMetadata() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        Log.log("User is NULL", color: LColor.white);
        return;
      }

      final String uid = user.uid;
      final String email = user.email ?? "NULL EMAIL";
      final String username = user.displayName ?? "NULL NAME";

      final String initBio = "Hello my name is $username";

      final Map<String, dynamic> targetData = {
        "uid": uid,
        "email": email,
        "bio": initBio,
        "username": username,
        "creationTime": FieldValue.serverTimestamp(),
      };

      // users.add(targetData);

      await _userDoc.set(targetData);

      Log.log("User metadata has been saved successfully");
    } on SocketException {
      Log.error("Internet connection error");
    } catch (error) {
      Log.error("Metadata Error => $error");
    }
  }

  // Update current user

  Future<void> updateUsername() async {
    try {
      final String newUsername = _auth.currentUser!.displayName ?? "NULL NAME";

      await _userDoc.update(
        <String, dynamic>{
          "username": newUsername,
        },
      );

      const SaveMetadata metaName = SaveMetadata(
        prefKey: PrefsKeys.USERNAME_KEYS,
      );

      await metaName.saveMetadata(data: newUsername);

      Log.log("User Metadata has been updated");
    } catch (error) {
      Log.error("Update Meta Error => $error");
    }
  }

  // Delete user

  Future<void> deleteUserFromDatabase() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        Log.log("User is NULL", color: LColor.white);
        return;
      }

      await _userDoc.delete();
    } catch (error) {
      showToastification(message: "Something went wrong");
      Log.log("Delete Error => $error");
    }
  }

  // Manage User BIO

  bool isLoading = false;

  SaveMetadata get bioMetadata =>
      const SaveMetadata(prefKey: PrefsKeys.USER_BIO_KEY);

  String get _bioText => AuthControllers.bioController!.text.trim();

  bool get _hasText => _bioText.isNotEmpty;

  Future<String> currentBio() async {
    final DocumentSnapshot userQuery = await _userDoc.get();

    final Map<String, dynamic> metadata =
        userQuery.data() as Map<String, dynamic>;

    final String currentUserBio = metadata["bio"] ?? "NULL BIO";

    return currentUserBio;
  }

  Future<bool> hasChange() async => (await currentBio() != _bioText);

   String get userName => _auth.currentUser!.displayName ?? "NULL NAME";
   String get userEmail => _auth.currentUser!.email ?? "NULL EMAIL";

  static String sessionBIO = "";

  Future<void> setBio({bool updateUI = false}) async {
    try {
      sessionBIO = await currentBio();
    } catch (error) {
      final String dbBio = await bioMetadata.metadataValue();
      sessionBIO = dbBio;
      Log.error("Setting BIO error => $error");
    }

    if (updateUI) {
      notifyListeners();
    }
  }

  Future<void> updateUserBIO() async {
    if (!_hasText) {
      showToastification(message: emptyBio, type: ToastificationType.error);
      return;
    }

    if (!await hasChange()) {
      Log.log("BIO has NO changes", color: LColor.white);

      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _userDoc.update({"bio": _bioText});

      await setBio(updateUI: true);

      await bioMetadata.saveMetadata(data: _bioText);

      Log.log("BIO has been Updated to => $_bioText");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Cart Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
       isLoading = false;
      notifyListeners();
    }
  }
}
