import 'package:flutter/material.dart';
import 'package:pantrily/screens/home/home_screen.dart';
import 'package:pantrily/screens/profile/profile_screen.dart';

class NavItem {
  final int id;
  final String icon;
  final String destination;

  NavItem({this.id, this.icon, this.destination});

  // if there is no destination
  bool destinationChecker() {
    if (destination != null) return true;
    return false;
  }
}

// if we make changes here the provider package will rebuild the widgets and use this nav tiems
class NavItems extends ChangeNotifier {
  int selectedIndex = 0;

  void changeNavIndex({int index}) {
    selectedIndex = index;
    // notify widgets that use this value so that it can rebuild.
    notifyListeners();
  }

  bool checkSameIndex({int index}) {
    if (selectedIndex == index) return true;
    return false;
  }

  List<NavItem> items = [
    NavItem(
      id: 1,
      icon: "assets/icons/home.svg",
      destination: '/home',
    ),
    NavItem(
      id: 2,
      icon: "assets/icons/list.svg",
    ),
    NavItem(
      id: 3,
      icon: "assets/icons/add.svg",
      destination: "/add",
    ),
    NavItem(
      id: 4,
      icon: "assets/icons/chef_nav.svg",
      destination: "/recipes",
    ),
    NavItem(
      id: 5,
      icon: "assets/icons/user.svg",
      destination: '/profile',
    ),
  ];
}
