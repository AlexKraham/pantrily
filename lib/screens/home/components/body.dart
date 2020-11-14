import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/models/SubCategory.dart';
import 'package:pantrily/screens/home/components/add_new_category.dart';
import 'package:pantrily/screens/home/components/subcategory_card.dart';
import 'package:pantrily/screens/home/components/subcategory_form.dart';
import 'package:pantrily/screens/home/components/test_api.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';
import 'categories.dart';

class Body extends StatelessWidget {
  // get showSettingsPanel => showSettingsPanel;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;

    void _showSubCategoryPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SubCategoryForm(),
            );
          });
    }

    return StreamProvider.value(
      value: DatabaseService().userData,
      child: SafeArea(
        child: Column(
          children: [
            Categories(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 2.0),
                child: GridView.count(
                  crossAxisCount:
                      SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  crossAxisSpacing:
                      SizeConfig.orientation == Orientation.landscape
                          ? SizeConfig.defaultSize * 2
                          : 0,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.0,
                  children: buildList(press: _showSubCategoryPanel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildList({Function press}) {
    List<Widget> list = List<Widget>.generate(
      subCategories.length,
      (index) => SubCategoryCard(
        subCategory: subCategories[index],
        press: () {
          print("Pressing: " + subCategories[index].title);
        },
      ),
    );
    list.add(
      AddNewCategory(
        press: press,
      ),
    );
    return list;
  }
}
