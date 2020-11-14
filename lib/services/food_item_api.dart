import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'dart:convert';
import 'package:pantrily/shared/constants.dart';

class FoodItemApi {
  // String foodId; // id of the food item
  // String label; // name of the food item
  // String imgSrc; // src image url
  // String category; // category of the food item

  String searchParam; // search param for API end point
  List<FoodItem> foodItems;
  String label;

  FoodItemApi({this.searchParam});

  Future<void> getSearchResults() async {
    try {
      Response response = await get(
          "https://api.edamam.com/api/food-database/v2/parser?ingr=$searchParam&app_id=$kAppId&app_key=$kApiKey");
      Map data = jsonDecode(response.body);
      // label = data['hints'][0]['food']['label'];
      List resultsArray = data['hints'];
      foodItems = new List();
      resultsArray.forEach((element) {
        var food = element['food'];
        foodItems.add(FoodItem(
            label: food['label'],
            foodId: food['foodId'],
            imgSrc: food['image'],
            category: food['category']));
      });
    } catch (e) {
      print('caught error: $e');
      label = "failed";
    }
    print("Do the thing");
  }
}
