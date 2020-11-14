import 'package:cloud_firestore/cloud_firestore.dart';
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

  // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     //print(doc.data);
  //     return Brew(
  //         name: doc.data()['name'] ?? '',
  //         strength: doc.data()['strength'] ?? 0,
  //         sugars: doc.data()['sugars'] ?? '0');
  //   }).toList();
  // }
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

  // get brews stream
  // Stream<List<Brew>> get brews {
  //   return userCollection.snapshots().map(_brewListFromSnapshot);
  // }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
