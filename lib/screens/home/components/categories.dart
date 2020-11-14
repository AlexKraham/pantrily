import 'package:flutter/material.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';

class Categories extends StatefulWidget {
  final Function setIndex;
  final int index;
  Categories({Key key, this.setIndex, this.index}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState(setIndex, index);
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "By Category",
    "All Items",
    "Pantry",
    "Fridge",
    "Freezer",
  ];
  int selectedIndex = 0;

  _CategoriesState(this.setIndex, this.index);
  Function setIndex;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
      child: SizedBox(
        height: SizeConfig.defaultSize * 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategoryItem(index),
        ),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        setIndex(index);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2,
          vertical: SizeConfig.defaultSize * 0.5,
        ),
        decoration: BoxDecoration(
          color: selectedIndex == index ? kSelectedBoxColor : kBoxColor,
          borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 1.6),
        ),
        child: Text(
          categories[index],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedIndex == index ? kPrimaryColor : kGreyColor),
        ),
      ),
    );
  }
}
