import 'package:flutter/material.dart';
import 'package:pantrily/screens/profile/components/ProfileBody.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: ProfileBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Text("Profile"),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize * 1.6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
