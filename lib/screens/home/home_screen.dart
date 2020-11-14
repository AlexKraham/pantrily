import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/home/components/body.dart';
import 'package:pantrily/screens/home/components/subcategory_form.dart';
import 'package:pantrily/services/auth.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/components/bottom_nav_bar.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final user = Provider.of<AppUser>(context);
    final DatabaseService db = DatabaseService(uid: user.uid);

    print("user in home screen");
    print(user.uid);

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SubCategoryForm(),
            );
          });
    }

    return StreamProvider<List<PantryItem>>.value(
      value: DatabaseService(uid: user.uid).streamPantryItems(),
      child: Scaffold(
        appBar: buildAppBar(),
        body: Body(),
        // we user provider to manage state of our nav
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Image.asset("assets/images/pantrily-logo.png"),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () {},
          ),
          SizedBox(
            width: SizeConfig.defaultSize * 0.5,
          ),
        ]);
  }
}
