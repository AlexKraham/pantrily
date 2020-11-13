import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/models/SubCategory.dart';
import 'package:pantrily/screens/home/components/subcategory_card.dart';
import 'package:pantrily/shared/size_config.dart';
import 'categories.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return SafeArea(
      child: Column(
        children: [
          Categories(),
          GestureDetector(
            onTap: () {
              print("Adding new category");
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultSize * 2),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: defaultSize * 1),
                      decoration: BoxDecoration(
                        color: Color(0xFFe6a44e),
                        borderRadius: BorderRadius.circular(defaultSize * 1.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/add.svg",
                            width: 18,
                            color: Colors.white,
                          ),
                          SizedBox(width: defaultSize * 1.5),
                          Text(
                            "Create New Category",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: defaultSize * 1.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize * 2.0),
              child: GridView.builder(
                itemCount: subCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  crossAxisSpacing:
                      SizeConfig.orientation == Orientation.landscape
                          ? SizeConfig.defaultSize * 2
                          : 0,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.0,
                ),
                itemBuilder: (context, index) => SubCategoryCard(
                  subCategory: subCategories[index],
                  press: () {
                    print("Pressing" + index.toString());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
