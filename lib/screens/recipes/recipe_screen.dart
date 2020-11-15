import 'package:flutter/material.dart';
import 'package:pantrily/shared/components/bottom_nav_bar.dart';

import 'components/recipe_body.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building recipe screen");
    return Scaffold(
      appBar: AppBar(),
      body: RecipeBody(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
