import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/screens/add/components/food_item_card.dart';
import 'package:pantrily/screens/add/components/search_form.dart';
import 'package:pantrily/services/food_item_api.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class AddIngredientForm extends StatefulWidget {
  @override
  _AddIngredientFormState createState() => _AddIngredientFormState();
}

class _AddIngredientFormState extends State<AddIngredientForm> {
  TextEditingController _searchController = TextEditingController();
  final defaultSize = SizeConfig.defaultSize;

  bool loading = false;
  List<FoodItem> foodItems = [];
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {}

  void pressSearch() async {
    setState(() {
      loading = true;
    });
    FoodItemApi instance = FoodItemApi(searchParam: _searchController.text);
    await instance.getSearchResults();
    setState(() {
      foodItems = instance.foodItems;
      loading = false;
    });
    print(foodItems);
  }

  @override
  Widget build(BuildContext context) {
    RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    // print(recipeBuilder.recipe.title);
    return Column(
      children: [
        Text(
          "Add new ingredient",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SearchForm(searchController: _searchController, press: pressSearch),
        Flexible(
          child: ListView(
            children: foodItems.map((item) {
              return FoodItemCard(
                foodItem: item,
                isRecipeForm: true,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
