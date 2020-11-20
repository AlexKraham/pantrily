import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/models/Ingredient.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/shared/constants.dart';

class Recipe {
  String title;
  String description;
  String imgSrc;
  List<Ingredient> ingredients; // this will be id's of each ingredient
  List<String> directions;
  String id;
  String uid;

  Recipe(
      {this.title,
      this.description,
      this.imgSrc,
      this.ingredients,
      this.directions,
      this.id,
      this.uid});

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    print(data['title']);
    // List ingreds = List.from(data['ingredients']);
    List dataIngreds = data['ingredients'] ?? [];
    List<Ingredient> ingreds = List.generate(dataIngreds.length, (i) {
      // create the foodItem
      FoodItem foodItem = FoodItem(
          imgSrc: dataIngreds[i]['imgSrc'] ?? kAnonImgSrc,
          foodId: dataIngreds[i]['foodId'] ?? "",
          label: dataIngreds[i]['label'] ?? "");
      return Ingredient(foodItem: foodItem, count: dataIngreds[i]['count']);
    });
    return Recipe(
        title: data['title'] ?? 'Untitled',
        description: data['description'] ?? 'No description',
        imgSrc: data['imgSrc'] ?? kAnonRecipeImgSrc,
        ingredients: ingreds,
        directions: List.from(data['directions']) ?? [],
        id: doc.id,
        uid: data['uid'] ?? 'missing uid');
  }
}
