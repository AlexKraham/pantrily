import 'package:flutter/material.dart';
import 'package:pantrily/screens/authenticate/authenticate.dart';
import 'package:pantrily/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either Home or Authenticate widget
    return Authenticate();
  }
}
