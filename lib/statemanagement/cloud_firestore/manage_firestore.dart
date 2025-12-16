import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/statemanagement/cloud_firestore/collections.dart';

class ManageFirestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //================ METADATA ================

  String get _usersCollection => Collections.USER_COLLECTION;

  String get _metaId => _auth.currentUser!.uid;

  // Add new user

  CollectionReference get users => _firestore.collection(
        _usersCollection,
      );

  Future<void> addNewUserMetadata() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        Log.log("User is NULL", color: LColor.white);
        return;
      }

      final String uid = user.uid;
      final String email = user.email ?? "NULL EMAIL";
      final String username = user.displayName ?? "NULL NAME";

      final Map<String, dynamic> targetData = {
        "uid": uid,
        "email": email,
        "username": username,
        "creationTime": FieldValue.serverTimestamp(),
      };

      // users.add(targetData);

      await users.doc(uid).set(targetData);

      Log.log("User metadata has been saved successfully");
    } on SocketException {
      Log.error("Internet connection error");
    } catch (error) {
      Log.error("Metadata Error => $error");
    }
  }

  // Update current user

  Future<void> updateUserMetadata() async {
    try {
      final String newUsername = _auth.currentUser!.displayName ?? "NULL NAME";

      await users.doc(_metaId).update(
        <String, dynamic>{
          "username": newUsername,
        },
      );

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
      final String uid = user.uid;
      await users.doc(uid).delete();
    } catch (error) {
      showToastification(message: "Something went wrong");
      Log.log("Delete Error => $error");
    }
  }

  //================ CART ================

  // Add new item to cart

  // Delete ite from cart

  //================ WISHLIST ================

  // Add new item to whsh list

  // Remove item from wishlist

  //================ RECEIPT ================

  // Add new receipt

  // Remove the receipt
}
