import 'package:flutter/material.dart';
import 'package:pantrily/models/Ingredient.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class RecipeDetailsBody extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsBody({Key key, this.recipe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double defaultSize = SizeConfig.defaultSize;
    final user = Provider.of<AppUser>(context);

    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xffc96f63),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(90),
                topRight: Radius.circular(50)), // 20
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultSize * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: defaultSize * 2.2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 0.5,
                      ),
                      Text(
                        recipe.description,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: defaultSize * 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Spacer(),
                      RaisedButton(
                        onPressed: () async {
                          await DatabaseService(uid: user.uid)
                              .deleteRecipe(recipe.id);
                          Navigator.pushReplacementNamed(context, "/recipes");
                        },
                        child: Text("Delete Recipe"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: defaultSize * 0.5,
              ),
              AspectRatio(
                aspectRatio: .8,
                child: Image.network(
                  kAnonRecipeImgSrc,
                  fit: BoxFit.cover,
                  // alignment: Alignment.centerLeft,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: defaultSize),
                decoration: BoxDecoration(
                  color: Color(0xFFe6a44e),
                  // borderRadius: BorderRadius.circular(defaultSize * .5),
                ),
                child: Text(
                  "Ingredients: ",
                  style: kRecipeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView(
                  children: recipe.ingredients.map((ingredient) {
                    return IngredientCard(
                      ingredient: ingredient,
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: defaultSize),
                decoration: BoxDecoration(
                  color: Color(0xFFe6a44e),
                  // borderRadius: BorderRadius.circular(defaultSize * .5),
                ),
                child: Text(
                  "Recipe Directions: ",
                  style: kRecipeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView(
                  children: List.generate(
                    recipe.directions.length,
                    (index) => DirectionCard(
                      direction: recipe.directions[index],
                      num: index + 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IngredientCard extends StatelessWidget {
  const IngredientCard({
    Key key,
    this.ingredient,
  }) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(ingredient.foodItem.imgSrc ??
                      "https://drive.google.com/uc?id=1FXtI6_dvW_YjtRjN9B7qq3yNkweqMwfH"),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                ingredient.foodItem.label,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Amount: " + ingredient.count.toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class DirectionCard extends StatelessWidget {
  const DirectionCard({
    Key key,
    this.direction,
    this.num,
  }) : super(key: key);

  final String direction;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: kPrimaryColor,
                border: Border.all(width: 3, color: kPrimaryColor),
              ),
              child: Text(
                num.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Column(
                children: [
                  Text(direction),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
