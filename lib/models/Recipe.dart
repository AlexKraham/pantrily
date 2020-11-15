import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/PantryItem.dart';

class Recipe {
  final String title;
  final String description;
  final String imgSrc;
  final List<String> ingredients; // this will be id's of each ingredient
  final List<String> directions;
  final String id;
  final String uid;

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
