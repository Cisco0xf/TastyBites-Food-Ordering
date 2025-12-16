// ignore_for_file: constant_identifier_names

class Collections {
  static const String USER_COLLECTION = "USER_COLLECTION";
  static const String CART_COLLECTION = "CART_COLLECTION";
  static const String WISHLIST_COLLECTION = "WISHLIST_COLLECTION";
  static const String METADATA_COLLECTION = "METADATA_COLLECTION";
  static const String RECEIPTS_COLLECTION = "RECEIPTS_COLLECTION";
}

/* 
==> Firestore will have the next collections:

  ==> Users =>
      ==> User Cart       (User Cart Items)
      ==> User Favorite   (User Favourite items)
      ==> User Metadata   (Username, BOI, ...)
      ==> User Receipts
 */