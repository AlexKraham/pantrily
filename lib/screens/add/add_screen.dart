import 'package:flutter/material.dart';
import 'package:pantrily/screens/add/components/add_body.dart';
import 'package:pantrily/shared/components/bottom_nav_bar.dart';
import 'package:pantrily/shared/constants.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Add To Pantry"),
      ),
      body: AddBody(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
