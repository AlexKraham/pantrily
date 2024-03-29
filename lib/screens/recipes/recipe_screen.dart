import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/components/bottom_nav_bar.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

import 'components/recipe_body.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    print("Building recipe screen");
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: DatabaseService(uid: user.uid).streamRecipes(),
        ),
        StreamProvider.value(
          value: DatabaseService(uid: user.uid).streamPantryItems(),
        ),
      ],
      child: Scaffold(
        appBar: buildAppBar(),
        body: RecipeBody(),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Image.asset("assets/images/pantrily-logo.png"),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () {},
          ),
          SizedBox(
            width: SizeConfig.defaultSize * 0.5,
          ),
        ]);
  }
}
