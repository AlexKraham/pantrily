import 'package:flutter/material.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/models/RecipeMatch.dart';
import 'package:pantrily/screens/recipes/components/recipe_card.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class RecipeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    // print(recipeBuilder);
    var recipes = Provider.of<List<Recipe>>(context) ?? [];
    var pantryItems = Provider.of<List<PantryItem>>(context) ?? [];
    print("recipe length: " + recipes.length.toString());

    Map pantryMap = {};
    var recipeMatches = [];

    void getRecipeMatches() {
      for (var item in pantryItems) {
        if (pantryMap.containsKey(item.foodId)) {
          pantryMap[item.foodId] += item.count;
        } else {
          pantryMap[item.foodId] = item.count;
        }
      }

      // print(pantryMap);
      for (var recipe in recipes) {
        print("inside mather, recipe: " + recipe.title);
        int numIngredients = 0;
        int matchedIngredients = 0;
        for (var ingredient in recipe.ingredients) {
          numIngredients += ingredient.count;
          var count = pantryMap[ingredient.foodItem.foodId] ?? 0;
          if (count > ingredient.count) count = ingredient.count;
          matchedIngredients += count;
        }
        RecipeMatch recipeMatch = RecipeMatch(
            recipe: recipe,
            numIngredients: numIngredients,
            matchedIngredients: matchedIngredients);
        recipeMatches.add(recipeMatch);
      }

      print("recipe matches length: " + recipeMatches.length.toString());
      recipeMatches.sort((a, b) {
        // print("RECIPE:" + a.recipe.title);
        //         // print("A: " + (a.matchedIngredients / a.numIngredients).toString());
        //         // print("B: " +
        //         //     b.recipe.title +
        //         //     (b.matchedIngredients / b.numIngredients).toString());
        //         int compare = (a.matchedIngredients / a.numIngredients)
        //             .compareTo((b.matchedIngredients / b.matchedIngredients));
        //         // if (compare == 0) {
        //         //   return a.recipe.title.compareTo(b.recipe.title);
        //         // } else {
        //         //   return compare;
        //         // }
        // double compare = (a.matchedIngredients / a.numIngredients) < (b.matchedIngredients / b.matchedIngredients);
        return (a.matchedIngredients / a.numIngredients) <
                (b.matchedIngredients / b.matchedIngredients)
            ? 1
            : -1;
      });

      // // print("recipe matches ength again" + recipeMatches.length.toString());
      // print("recipe match");
      // print(recipeMatches[3].recipe.title);
      // print(recipeMatches[3].matchedIngredients);
    }

    getRecipeMatches();

    TextEditingController _searchController = TextEditingController();
    final defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffc96d59),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffc96d59),
                        width: 1.8,
                      ),
                    ),
                    hintText: "Enter recipe name",
                  ),
                ),
              ),
              FlatButton(
                color: kPrimaryColor,
                onPressed: () {},
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          FlatButton(
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pushNamed(context, "/addrecipe");
            },
            child: Text(
              "Add New Recipe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: GridView.count(
                crossAxisCount:
                    SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                crossAxisSpacing:
                    SizeConfig.orientation == Orientation.landscape
                        ? SizeConfig.defaultSize * 2
                        : 0,
                mainAxisSpacing: 20,
                childAspectRatio: 2.0,
                children: List.generate(
                    recipeMatches.length,
                    (i) => RecipeCard(
                          recipeMatch: recipeMatches[i],
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// [
// RecipeCard(
// recipe: Recipe(
// title: "Chicken Alfredo",
// description: "Yummy and delicious pasta",
// imgSrc: kAnonRecipeImgSrc,
// ),
// ),
// RecipeCard(
// recipe: Recipe(
// title: "Caesar Salad",
// description: "A salad for anyone to enjoy",
// imgSrc: kAnonRecipeImgSrc,
// ),
// ),
// ],
