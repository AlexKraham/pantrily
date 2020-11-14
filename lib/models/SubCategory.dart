import 'package:flutter/material.dart';

class SubCategory {
  final int numItems;
  final String id;
  final String title, description, imageSrc;
  final Color color;

  SubCategory(
      {this.id,
      this.numItems,
      this.title,
      this.description,
      this.imageSrc,
      this.color});
}

// demo of sub categories
List<SubCategory> subCategories = [
  SubCategory(
    id: "1",
    numItems: 5,
    title: "Fruits and Vegetables",
    description: "All your fruits and vegetables in your pantry",
    imageSrc: "assets/images/cook_new@2x.png",
    color: Color(0xFFD82D40),
  ),
  SubCategory(
    id: "2",
    numItems: 3,
    title: "Meats and Seafood",
    description: "Your average poultry, seafood, red meats, etc...",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Color(0xFF90AF17),
  ),
  SubCategory(
    id: "3",
    numItems: 9,
    title: "Dairy",
    description: "Cheese, milk, eggs and other dairy products",
    imageSrc: "assets/images/food_court@2x.png",
    color: Color(0xFF2DBBD8),
  ),
  SubCategory(
    id: "4",
    numItems: 3,
    title: "Spices",
    description: "a lithany of spices and such",
    imageSrc: "assets/images/kisspng_chicken_tikka.png",
    color: Color(0xFFfabf1e),
  ),
];
