import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/models/Ingredient.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class AddIngredientDetails extends StatefulWidget {
  const AddIngredientDetails({Key key, this.foodItem}) : super(key: key);

  final FoodItem foodItem;

  @override
  _AddIngredientDetailsState createState() =>
      _AddIngredientDetailsState(foodItem);
}

class _AddIngredientDetailsState extends State<AddIngredientDetails> {
  final _formKey = GlobalKey<FormState>();

  _AddIngredientDetailsState(this.foodItem);

  final FoodItem foodItem;

  int _currentCount;
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    print(recipeBuilder.recipe.title);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Adding Ingredient",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.foodItem.imgSrc ??
                        "https://drive.google.com/uc?id=1FXtI6_dvW_YjtRjN9B7qq3yNkweqMwfH"),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      StringUtils.capitalize(widget.foodItem.label ?? ""),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      widget.foodItem.category ?? "",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          // DropdownButtonFormField(
          //   decoration: InputDecoration(
          //     labelText: "Select Area",
          //   ),
          //   items: areas.map((area) {
          //     return DropdownMenuItem(
          //       value: area,
          //       child: Text('$area'),
          //     );
          //   }).toList(),
          //   onChanged: (val) => setState(() {}),
          // ),
          // DropdownButtonFormField(
          //   decoration: InputDecoration(
          //     labelText: "Select Category",
          //   ),
          //   items: categories.map((category) {
          //     return DropdownMenuItem(
          //       value: category,
          //       child: Text('$category'),
          //     );
          //   }).toList(),
          //   onChanged: (val){},
          // ),
          // SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Select Amount Required For Recipe",
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
              hoverColor: kPrimaryColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              focusColor: kPrimaryColor,
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) => setState(() {
              _currentCount = int.parse(val);
            }),
          ),
          SizedBox(height: 10.0),
          FlatButton(
              color: kPrimaryColor,
              child: Text(
                'Add To Recipe',
                style:
                    TextStyle(color: Colors.white, fontSize: defaultSize * 1.7),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Ingredient ingredient =
                      Ingredient(foodItem: foodItem, count: _currentCount);
                  recipeBuilder.addIngredient(ingredient);
                  Navigator.pop(context);
                }
                // recipe
              }),
        ],
      ),
    );
  }
}
