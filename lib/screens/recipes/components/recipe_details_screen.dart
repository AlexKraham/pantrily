import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/screens/recipes/components/recipe_details_body.dart';
import 'package:pantrily/shared/components/bottom_nav_bar.dart';
import 'package:pantrily/shared/size_config.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RecipeDetailsBody(recipe: recipe),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/pantrily-logo.png"),
        actions: <Widget>[
          SizedBox(
            width: SizeConfig.defaultSize * 0.5,
          ),
        ]);
  }
}
