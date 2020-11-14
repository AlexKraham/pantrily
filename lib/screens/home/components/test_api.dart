import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pantrily/services/food_item_api.dart';

class TestApi extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TestApi> {
  String result = "Loading";
  void setupFoodItemSearch() async {
    print("Setting up food item search");
    FoodItemApi instance = FoodItemApi(searchParam: "red apple");
    await instance.getSearchResults();
    setState(() {
      result = instance.label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(result ?? ""),
    );
  }

  @override
  void initState() {
    super.initState();
    setupFoodItemSearch();
  }
}
