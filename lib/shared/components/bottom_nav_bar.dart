import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrily/models/NavItem.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    print("Buidling");
    return Consumer<NavItems>(
      builder: (context, navItems, child) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultSize * 3,
        ),
        // height: 80.0,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            offset: Offset(0, -7),
            blurRadius: 30,
            color: Color(0xFF4B1A39).withOpacity(0.2),
          )
        ]),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              navItems.items.length,
              (index) => buildIconNavItem(
                isActive: navItems.selectedIndex == index ? true : false,
                icon: navItems.items[index].icon,
                press: () {
                  // if (navItems.checkSameIndex(index: index)) {
                  //   print("same index, shouldn't push a new screen");
                  //   return;
                  // }
                  navItems.changeNavIndex(index: index);
                  // if there is a destination, add that page and show to user
                  if (navItems.items[index].destinationChecker())
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => navItems.items[index].destination,
                    //   ),
                    // );
                    // print("pushing to: " + navItems.items[index].destination);

                    Navigator.pushReplacementNamed(
                        context, navItems.items[index].destination);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildIconNavItem(
      {String icon, Function press, bool isActive = false}) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        color: isActive ? kPrimaryColor : kInactiveColor,
        height: 22,
      ),
      onPressed: press,
    );
  }
}
