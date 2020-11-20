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
    imageSrc: "assets/images/fruits.png",
    color: Color(0xFFD82D40),
  ),
  SubCategory(
    id: "2",
    numItems: 3,
    title: "Meats and Seafood",
    description: "Your average poultry, seafood, red meats, etc...",
    imageSrc: "assets/images/kisspng_chicken_tikka.png",
    color: Color(0xFF90AF17),
  ),
  SubCategory(
    id: "3",
    numItems: 9,
    title: "Dairy",
    description: "Cheese, milk, eggs and other dairy products",
    imageSrc: "assets/images/dairyb.png",
    color: Color(0xFF2DBBD8),
  ),
  SubCategory(
    id: "4",
    numItems: 3,
    title: "Spices",
    description: "a lithany of spices and such",
    imageSrc: "assets/images/spices.png",
    color: Color(0xFFfabf1e),
  ),
  SubCategory(
    id: "5",
    numItems: 3,
    title: "Dry Items",
    description: "Dry pasta, cereal, and other pantry items.",
    imageSrc: "assets/images/pasta.png",
    color: Color(0xff998FC7),
  ),
  SubCategory(
    id: "6",
    numItems: 3,
    title: "Snacks",
    description: "Chips, sweets, candies galore.",
    imageSrc: "assets/images/snacks.png",
    color: Color(0xffFFBCB5),
  ),
  SubCategory(
    id: "7",
    numItems: 3,
    title: "Condiments",
    description: "Your ketchups, ranches, mustards and more.",
    imageSrc: "assets/images/condiments.png",
    color: Color(0xff8CD790),
  ),
  SubCategory(
    id: "8",
    numItems: 3,
    title: "Other",
    description: "Anything that doesn't fit elsewhere",
    imageSrc: "assets/images/other.png",
    color: Color(0xff444B6E),
  ),
];
