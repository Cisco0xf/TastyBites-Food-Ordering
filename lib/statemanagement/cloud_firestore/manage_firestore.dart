import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/statemanagement/cloud_firestore/collections.dart';

class ManageFirestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //================ METADATA ================

  String get _usersCollection => Collections.USER_COLLECTION;

  String get _userId => _auth.currentUser!.uid;

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

      await users.doc(_userId).update(
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

      await users.doc(_userId).delete();
    } catch (error) {
      showToastification(message: "Something went wrong");
      Log.log("Delete Error => $error");
    }
  }

  //================ CART ================

  CollectionReference get _cartCollection =>
      users.doc(_userId).collection(Collections.CART_COLLECTION);

  // Add new item to cart

  Future<void> addNewItemToFirestoreCart({required FoodModel target}) async {
    final bool hasUser = _auth.currentUser != null;

    if (!hasUser) {
      Log.log("User is NULL", color: LColor.white);
      return;
    }

    try {
      await _cartCollection.doc(target.id).set(target.fromModel(item: target));

      Log.log("Item has been added to cart successfully...");
    } catch (error) {
      Log.error("Cart Adding error => $error");
    }
  }

  // Delete ite from cart

  Future<void> removeItemFromFirestoreCart({required FoodModel target}) async {
    try {
      await _cartCollection.doc(target.id).delete();
    } catch (error) {
      Log.error("REMOVE Erro => $error");
    }
  }

  // Clear Firestore Cart

  Future<void> clearFirestoreCart() async {
    try {
      final QuerySnapshot allCart = await _cartCollection.get();

      final List<QueryDocumentSnapshot> cartDocs = allCart.docs;

      final WriteBatch batch = _firestore.batch();
      for (int i = 0; i < cartDocs.length; i++) {
        batch.delete(cartDocs[i].reference);
      }

      await batch.commit();
    } catch (error) {
      Log.error("Error Clear Cart => $error");
    }
  }

  //================ WISHLIST ================

  CollectionReference get _wishListCollection =>
      users.doc(_userId).collection(Collections.WISHLIST_COLLECTION);

  // Add new item to whsh list

  Future<void> addNewItemToWishlist(FoodModel target) async {
    try {
      await _wishListCollection.doc(target.id).set(
            target.fromModel(item: target),
          );

      Log.log("Item has been added to WishList successfully...");
    } catch (error) {
      Log.error("WishList Adding Error => $error");
    }
  }

  // Remove item from wishlist

  Future<void> removeItemFromWhishList(FoodModel target) async {
    try {
      await _wishListCollection.doc(target.id).delete();

      Log.log("Item has been removed from firestore whshlist");
    } catch (error) {
      Log.error("Remove Error => $error");
    }
  }

  //================ RECEIPT ================

  CollectionReference get _receiptCollection =>
      users.doc(_userId).collection(Collections.RECEIPTS_COLLECTION);

  // Add new

  Future<void> addNewReceuptToFirestore({required ReceiptModel receipt}) async {
    try {
      await _receiptCollection.doc(receipt.id).set(receipt.fromModel(receipt));

      Log.log("New Receipt Added to Firestore successfully...");
    } catch (error) {
      Log.error("Receipt Adding error => $error");
    }
  }

  // Remove the receipt

  Future<void> removeReceiptFromFirestore(ReceiptModel receipt) async {
    try {
      await _receiptCollection.doc(receipt.id).delete();

      Log.log("Receipt remove from firestore");
    } catch (error) {
      Log.error("Delete Receipt Error => $error");
    }
  }

  // Clear receipts

  Future<void> clearReceiptFirestore() async {
    try {
      final QuerySnapshot receiptQuery = await _receiptCollection.get();

      final List<QueryDocumentSnapshot> receiptData = receiptQuery.docs;

      final WriteBatch batch = _firestore.batch();

      for (int i = 0; i < receiptData.length; i++) {
        batch.delete(receiptData[i].reference);
      }

      await batch.commit();

      Log.log("Receipts has been deleted successfully...");
    } catch (error) {
      Log.error("Clear Receipt Error => $error");
    }
  }
}
