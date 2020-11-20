import 'package:flutter/material.dart';
import 'package:pantrily/models/RecipeMatch.dart';
import 'package:pantrily/screens/recipes/components/recipe_details_screen.dart';
import 'package:pantrily/shared/size_config.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    this.recipeMatch,
  }) : super(key: key);

  final RecipeMatch recipeMatch;
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;

    Color matchColor = Color(0xff6db372);
    if (recipeMatch.matchedIngredients == recipeMatch.numIngredients) {
      matchColor = Color(0xffa5bda4);
    } else if (recipeMatch.matchedIngredients / recipeMatch.numIngredients >
        .7) {
      matchColor = Color(0xffe3dfa6);
    } else {
      // matchColor = Color(0xffe3dfa6);

      matchColor = Color(0xffffffff);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipe: recipeMatch.recipe,
            ),
          ),
        );
      },
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
                      recipeMatch.recipe.title,
                      style: TextStyle(
                        fontSize: defaultSize * 2.2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: defaultSize * 0.5,
                    ),
                    Text(
                      recipeMatch.recipe.description,
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
                          color: matchColor,
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
                        child: Text(recipeMatch.matchedIngredients.toString() +
                            "/" +
                            recipeMatch.numIngredients.toString() +
                            " Pantry Match"),
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
                recipeMatch.recipe.imgSrc,
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
