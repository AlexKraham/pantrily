import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/PantryItem.dart';

class Recipe {
  String title;
  String description;
  String imgSrc;
  List<String> ingredients; // this will be id's of each ingredient
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
    return Recipe(
        title: doc['title'] ?? 'Untitled',
        description: doc['description'] ?? 'No description',
        imgSrc: doc['imgSrc'] ?? '',
        ingredients: List.from(doc['ingredients']) ?? [],
        directions: List.from(doc['directions']) ?? [],
        id: doc.id,
        uid: doc['uid'] ?? 'missing uid');
  }
}
