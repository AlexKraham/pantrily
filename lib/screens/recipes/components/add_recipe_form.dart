import 'package:flutter/material.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/recipes/components/add_ingredient_form.dart';
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
    // RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    // print("Building add recipe form");
    // print(recipeBuilder);
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
                  // builder.setTitle(val);
                  // print(builder.recipe.title);
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ingredients:",
                    style: kRecipeTextStyle,
                    textAlign: TextAlign.start,
                  ),
                  Card(
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
                                image: NetworkImage(null ??
                                    "https://drive.google.com/uc?id=1FXtI6_dvW_YjtRjN9B7qq3yNkweqMwfH"),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text("Ingredient number 1"),
                            Text("Amount")
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit), onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.delete), onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Ingredient 1",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Ingredient 2",
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FlatButton(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '+ Add Ingredient',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultSize * 1.7),
                        ),
                      ),
                      onPressed: () async {
                        // if (_formKey.currentState.validate()) {
                        //   // addItem();
                        // }
                        _showAddIngredientForm();
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Directions:",
                    style: kRecipeTextStyle,
                  ),
                  Text("Step 1: Cut the chicken to strips"),
                  Text("Step 2: Season with garlic powder, salt, and pepper"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FlatButton(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 32),
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '+ Add a step',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultSize * 1.7),
                        ),
                      ),
                      onPressed: () async {
                        // if (_formKey.currentState.validate()) {
                        //   _show
                        // }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
