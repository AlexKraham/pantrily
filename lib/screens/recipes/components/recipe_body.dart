import 'package:flutter/material.dart';
import 'package:pantrily/models/Recipe.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class RecipeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // RecipeBuilder recipeBuilder = Provider.of<RecipeBuilder>(context);
    // print(recipeBuilder);

    TextEditingController _searchController = TextEditingController();
    final defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffc96d59),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffc96d59),
                        width: 1.8,
                      ),
                    ),
                    hintText: "Enter recipe name",
                  ),
                ),
              ),
              FlatButton(
                color: kPrimaryColor,
                onPressed: () {},
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          FlatButton(
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pushNamed(context, "/addrecipe");
            },
            child: Text(
              "Add New Recipe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: GridView.count(
                crossAxisCount:
                    SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                crossAxisSpacing:
                    SizeConfig.orientation == Orientation.landscape
                        ? SizeConfig.defaultSize * 2
                        : 0,
                mainAxisSpacing: 20,
                childAspectRatio: 2.0,
                children: [
                  RecipeCard(
                    recipe: Recipe(
                      title: "Chicken Alfredo",
                      description: "Yummy and delicious pasta",
                      imgSrc: kAnonRecipeImgSrc,
                    ),
                  ),
                  RecipeCard(
                    recipe: Recipe(
                      title: "Caesar Salad",
                      description: "A salad for anyone to enjoy",
                      imgSrc: kAnonRecipeImgSrc,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    this.recipe,
  }) : super(key: key);

  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffc96f63),
          borderRadius: BorderRadius.circular(defaultSize * .6), // 20
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
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(defaultSize * .5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: .5,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(defaultSize * .5),
                        child: Text("8/9 Pantry Match"),
                      ),
                    ),

                    // buildInfoRow(
                    //   defaultSize,
                    //   iconSrc: "assets/icons/chef.svg",
                    //   text: "${subCategory.numItems} items",
                    // ),
                    // SizedBox(height: defaultSize * 0.5),
                    // buildInfoRow(
                    //   defaultSize,
                    //   iconSrc: "assets/icons/pot.svg",
                    //   text:
                    //       "${subCategory.numItems} items almost expired",
                    // ),
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
                recipe.imgSrc,
                fit: BoxFit.cover,
                // alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }
}
