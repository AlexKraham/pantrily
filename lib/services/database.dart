import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pantrily/models/SubCategory.dart';
import 'package:pantrily/models/brew.dart';
import 'package:pantrily/models/user.dart';

class DatabaseService {
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
      'label': label,
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
}
