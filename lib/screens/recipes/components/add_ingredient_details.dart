import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:provider/provider.dart';

class AddIngredientDetails extends StatelessWidget {
  const AddIngredientDetails({Key key, this.foodItem}) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    // Recipe recipe = Provider.of<RecipeBuilder>(context).getRecipe();
    // print(recipe.title);
    return Container();
  }
}
