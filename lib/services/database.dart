import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/models/SubCategory.dart';
import 'package:pantrily/models/brew.dart';
import 'package:pantrily/models/user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference subCategoryCollection =
      FirebaseFirestore.instance.collection('subcategories');

  final CollectionReference pantryCollection =
      FirebaseFirestore.instance.collection("pantries");

  final CollectionReference pantryItemCollection =
      FirebaseFirestore.instance.collection("pantryitems");

  // Get a stream of a single pantry item
  Stream<PantryItem> streamPantryItem(String id) {
    return _db
        .collection("pantries")
        .doc(uid)
        .collection("pantryItems")
        .doc(id)
        .snapshots()
        .map((snap) => PantryItem.fromFireStore(snap));
  }

  Future<void> deletePantryItem(String id) {
    var ref = _db.collection("pantries").doc(uid).collection("pantryItems");
    return ref.doc(id).delete();
  }

  // Get a stream of a subcollection pantry items
  Stream<List<PantryItem>> streamPantryItems() {
    var ref = _db.collection("pantries").doc(uid).collection('pantryItems');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => PantryItem.fromFireStore(doc)).toList());
  }

  // get a stream of subcollection pantry items based on area
  Stream<List<PantryItem>> streamPantryItemsByArea(String area) {
    var ref = _db
        .collection("pantries")
        .doc(uid)
        .collection("pantryItems")
        .where("area", isEqualTo: area);
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => PantryItem.fromFireStore(doc)).toList());
  }

  Future<void> updateUserData(
      {String name, String email, String imgSrc}) async {
    return await userCollection.doc(uid).set({
      'imgSrc': imgSrc,
      'name': name,
      'email': email,
    });
  }

  Future<void> createSubCategory(
      {String title, String description, String imgSrc}) async {
    print("Adding now");
    return await subCategoryCollection.add({
      'uid': uid,
      'title': title,
      'description': description,
      'imgSrc': imgSrc,
    });
  }

  // add pantry into
  Future<void> addPantryItem({
    String foodId,
    String label,
    String imgSrc,
    String category,
    String area,
    int count,
  }) async {
    return pantryCollection.doc(uid).collection('pantryItems').add({
      'foodId': foodId,
      'label': StringUtils.capitalize(label, allWords: true),
      'imgSrc': imgSrc,
      'category': category,
      'area': area,
      'count': count,
      'date': DateTime.now(),
    });
  }

  List<SubCategory> _subCategoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SubCategory(
        id: "1",
        title: doc.data()['title'] ?? '',
        description: doc.data()['description'] ?? '',
        imageSrc: doc.data()['imgSrc'] ?? '',
      );
    });
  }

  List<PantryItem> _pantryItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PantryItem();
    });
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        email: snapshot.data()['email'],
        imgSrc: snapshot.data()['imgSrc']);
  }

  Stream<List<SubCategory>> get subcategories {
    return subCategoryCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_subCategoryListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<PantryItem>> get pantryItems {
    print("Getting stream");
    return pantryCollection
        .doc(uid)
        .collection("pantryItems")
        .snapshots()
        .map(_pantryItemListFromSnapshot);
  }

  // Future<QuerySnapshot> getDataCollection(){
  //   return ref.getDocuments();
  // }
}
