import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/models/RecipeMatch.dart';
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

  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection("recipes");

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

  Future<void> deleteRecipe(String id) {
    return _db.collection("recipes").doc(id).delete();
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

  Stream<List<PantryItem>> streamPantryItemsByCategory(String category) {
    var ref = _db
        .collection("pantries")
        .doc(uid)
        .collection("pantryItems")
        .where("category", isEqualTo: category);
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => PantryItem.fromFireStore(doc)).toList());
  }

  Stream<List<Recipe>> streamRecipes() {
    var ref = recipeCollection.where('uid', isEqualTo: uid);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Recipe.fromFirestore(doc)).toList());
  }

  // Future<Stream<List<RecipeMatch>>> streamRecipeMatches() async {
  //   var recipes = await recipeCollection.where('uid', isEqualTo: uid).get();
  //   List<Recipe> recipes.docs.map((e) => null);
  // }

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

  Future<void> addRecipe({Recipe recipe}) async {
    List ingredients = recipe.ingredients;
    return recipeCollection.add({
      'title': recipe.title,
      'description': recipe.description ?? "",
      'ingredients': List.generate(
          recipe.ingredients.length,
          (i) => {
                'label': ingredients[i].foodItem.label,
                'imgSrc': ingredients[i].foodItem.imgSrc,
                'foodId': ingredients[i].foodItem.foodId,
                'count': ingredients[i].count,
              }),
      'directions': recipe.directions,
      'uid': recipe.uid
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
