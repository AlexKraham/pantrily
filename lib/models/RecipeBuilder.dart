import 'package:flutter/material.dart';
import 'package:pantrily/models/Recipe.dart';

class RecipeBuilder extends ChangeNotifier {
  Recipe recipe = new Recipe();

  void setTitle(String title) {
    recipe.title = title;
    notifyListeners();
  }

  Recipe getRecipe() {
    return recipe;
  }
}
