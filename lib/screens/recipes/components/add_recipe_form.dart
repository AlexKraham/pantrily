import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/Ingredient.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/recipes/components/add_ingredient_form.dart';
import 'package:pantrily/screens/recipes/components/add_step_form.dart';
import 'package:pantrily/shared/components/bottom_nav_bar.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentTitle;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    print("Building add recipe form");
    List ingredients = recipeBuilder.recipe.ingredients;
    List directions = recipeBuilder.recipe.directions;
    // print(recipeBuilder.recipe.ingredients);
    // RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    print(recipeBuilder);
    final defaultSize = SizeConfig.defaultSize;
    bool loading = false;
    bool success = false;

    // RecipeBuilder builder = RecipeBuilder();

    void _showAddIngredientForm() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: AddIngredientForm(),
            );
          });
    }

    void _showAddStepForm() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: AddStepForm(),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Add New Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Recipe Name",
                  labelStyle: TextStyle(
                    color: kPrimaryColor,
                  ),
                  hoverColor: kPrimaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  focusColor: kPrimaryColor,
                ),
                onChanged: (val) => setState(() {
                  _currentTitle = val;
                  recipeBuilder.setTitle(val);
                  // builder.setTitle(val);
                  // print(builder.recipe.title);
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RecipeFormTitle(
                        defaultSize: defaultSize, title: "Ingredients"),
                    // IngredientCard(),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView(
                        children: ingredients.map((ingredient) {
                          return IngredientCard(
                            ingredient: ingredient,
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        // color: Colors.black,
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '+ Add Ingredient',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultSize * 1.7),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        print("tapping");
                        _showAddIngredientForm();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RecipeFormTitle(
                        defaultSize: defaultSize, title: "Directions"),
                    Expanded(
                      child: ListView(
                        // children: directions.map((direction) {
                        //   return DirectionCard(
                        //     direction: direction,
                        //   );
                        // }).toList(),
                        children: [
                          DirectionCard(
                            direction: "test",
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        // color: Colors.black,
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '+ Add Step',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultSize * 1.7),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        // print("tapping");
                        _showAddStepForm();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                child: Container(
                  // color: Colors.black,
                  padding:
                      EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Color(0xffad4c31),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Add & Save Recipe',
                    style: TextStyle(
                        color: Colors.white, fontSize: defaultSize * 1.7),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  print("tapping");
                  _showAddIngredientForm();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class RecipeFormTitle extends StatelessWidget {
  const RecipeFormTitle({
    Key key,
    @required this.defaultSize,
    this.title,
  }) : super(key: key);

  final double defaultSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultSize),
      decoration: BoxDecoration(
        color: Color(0xFFe6a44e),
        borderRadius: BorderRadius.circular(defaultSize * .5),
      ),
      child: Text(
        title,
        style: kRecipeTextStyle,
        textAlign: TextAlign.center,
      ),
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
              Text(
                "Amount: " + ingredient.count.toString(),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            ],
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
                "1",
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
                  Text(
                      "ACBABEIOCNIOECO:Isdkjflka;sdkjskl;djfk;lsdjk;lfjsd;klfjdks;ljfk;lsdjfk;ljsd;kljfkld;jskl;jsadljsl;kdjckl;sjadkl;cja;klsdj;lkcjs;lkjcs;klk;djskl;cjd;sfdl;N:AJ:KLSJKL:DJ")
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
