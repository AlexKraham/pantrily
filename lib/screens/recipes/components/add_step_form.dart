import 'package:flutter/material.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';

class AddStepForm extends StatefulWidget {
  @override
  _AddStepFormState createState() => _AddStepFormState();
}

class _AddStepFormState extends State<AddStepForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentStep;
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Add new step",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            maxLines: 6,
            decoration: InputDecoration(
              labelText: "Enter next step for the recipe",
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
              _currentStep = val;
            }),
          ),
          SizedBox(height: 10.0),
          FlatButton(
              color: kPrimaryColor,
              child: Text(
                'Add Step To Recipe',
                style:
                    TextStyle(color: Colors.white, fontSize: defaultSize * 1.7),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  // Ingredient ingredient =
                  // Ingredient(foodItem: foodItem, count: _currentCount);
                  // recipeBuilder.addIngredient(ingredient);
                  Navigator.pop(context);
                }
                // recipe
              }),
        ],
      ),
    );
  }
}
