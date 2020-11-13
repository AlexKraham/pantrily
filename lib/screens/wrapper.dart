import 'package:flutter/material.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/authenticate/authenticate.dart';
import 'package:pantrily/screens/home/home.dart';
import 'package:pantrily/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user);
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
