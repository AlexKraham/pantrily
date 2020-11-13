import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/screens/profile/components/ProfileMenuItem.dart';
import 'package:pantrily/screens/profile/components/info.dart';
import 'package:pantrily/services/auth.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';

class ProfileBody extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return SingleChildScrollView(
      child: Column(
        children: [
          Info(
            name: "Alexander Phan",
            image: "assets/images/anonymous-user.png",
            email: "alexander.phan@me.com",
          ),
          SizedBox(
            height: defaultSize * 2,
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/bookmark_fill.svg",
            title: "Saved Recipes",
            press: () {
              print("pressed saved recipes");
            },
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/chef_color.svg",
            title: "Premium Account",
            press: () {
              print("pressed premium");
            },
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Help",
            press: () {
              print("pressed help button");
            },
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/logout.svg",
            title: "Logout",
            press: () async {
              print("logging out");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/authenticate', (Route<dynamic> route) => false);
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
