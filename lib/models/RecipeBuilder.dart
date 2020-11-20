import 'package:flutter/material.dart';
import 'package:pantrily/models/Ingredient.dart';
import 'package:pantrily/models/Recipe.dart';

class RecipeBuilder extends ChangeNotifier {
  Recipe recipe = new Recipe(ingredients: [], directions: []);

  void setTitle(String title) {
    recipe.title = title;
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    recipe.ingredients.add(ingredient);
    notifyListeners();
  }

  void addDirection(String direction) {
    recipe.directions.add(direction);
    notifyListeners();
  }

  Recipe getRecipe() {
    return recipe;
  }
}
