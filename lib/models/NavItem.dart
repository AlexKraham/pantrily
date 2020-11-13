import 'package:flutter/material.dart';
import 'package:pantrily/screens/home/home_screen.dart';

class NavItem {
  final int id;
  final String icon;
  final Widget destination;

  NavItem({this.id, this.icon, this.destination});

  // if there is no destination
  bool destinationChecker() {
    if (destination != null) return false;
    return true;
  }
}

// if we make changes here the provider package will rebuild the widgets and use this nav tiems
class NavItems extends ChangeNotifier {
  int selectedIndex = 0;
  List<NavItem> items = [
    NavItem(
      id: 1,
      icon: "assets/icons/home.svg",
      destination: HomeScreen(),
    ),
    NavItem(
      id: 2,
      icon: "assets/icons/list.svg",
    ),
    NavItem(
      id: 3,
      icon: "assets/icons/add.svg",
    ),
    NavItem(
      id: 4,
      icon: "assets/icons/chef_nav.svg",
    ),
    NavItem(
      id: 5,
      icon: "assets/icons/user.svg",
    ),
  ];
}
