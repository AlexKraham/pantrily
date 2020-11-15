import 'package:flutter/material.dart';
import 'package:pantrily/models/user.dart';
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
    final defaultSize = SizeConfig.defaultSize;
    bool loading = false;
    bool success = false;

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
                onChanged: (val) => setState(() => _currentTitle = val),
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
                        if (_formKey.currentState.validate()) {
                          // addItem();
                        }
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
                        if (_formKey.currentState.validate()) {
                          // addItem();
                        }
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
