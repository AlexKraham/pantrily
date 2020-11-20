import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/screens/add/components/food_item_card.dart';
import 'package:pantrily/screens/add/components/search_form.dart';
import 'package:pantrily/services/food_item_api.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/loading.dart';
import 'package:pantrily/shared/size_config.dart';

class AddBody extends StatefulWidget {
  @override
  _AddBodyState createState() => _AddBodyState();
}

class _AddBodyState extends State<AddBody> {
  TextEditingController _searchController = TextEditingController();
  final defaultSize = SizeConfig.defaultSize;

  bool loading = false;
  List<FoodItem> foodItems = new List();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    // print(_searchController.text);
  }

  //
  void pressSearch() async {
    print(_searchController.text);
    setState(() {
      loading = true;
    });
    FoodItemApi instance = FoodItemApi(searchParam: _searchController.text);
    await instance.getSearchResults();
    setState(() {
      foodItems = instance.foodItems;
      print(foodItems);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchForm(searchController: _searchController, press: pressSearch),
        loading
            ? Loading()
            : Flexible(
                child: ListView(
                  children: foodItems.map((item) {
                    return FoodItemCard(
                      foodItem: item,
                      isRecipeForm: false,
                    );
                  }).toList(),
                ),
              )
      ],
    );
  }
}
