import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/models/SubCategory.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/home/components/add_new_category.dart';
import 'package:pantrily/screens/home/components/subcategory_card.dart';
import 'package:pantrily/screens/home/components/subcategory_form.dart';
import 'package:pantrily/screens/home/components/test_api.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/loading.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';
import 'categories.dart';

class Body extends StatefulWidget {
  // get showSettingsPanel => showSettingsPanel;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int index = 0;

  List<PantryItem> items = [PantryItem(), PantryItem()];

  @override
  void initState() {
    print("INIT STATE CALLED");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    final user = Provider.of<AppUser>(context);

    var pantryItems = Provider.of<List<PantryItem>>(context) ?? [];
    // print("Pantry item");
    // print(pantryItems);

    void _showSubCategoryPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SubCategoryForm(),
            );
          });
    }

    void setIndex(newIndex) {
      setState(() {
        index = newIndex;
        print(index);
      });
    }

    return SafeArea(
      child: Column(
        children: [
          Categories(setIndex: setIndex),
          ConditionalSwitch.single(
            context: context,
            valueBuilder: (BuildContext context) => index,
            caseBuilders: {
              0: (BuildContext context) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 2.0),
                      child: GridView.count(
                        crossAxisCount:
                            SizeConfig.orientation == Orientation.landscape
                                ? 2
                                : 1,
                        crossAxisSpacing:
                            SizeConfig.orientation == Orientation.landscape
                                ? SizeConfig.defaultSize * 2
                                : 0,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2.0,
                        children: buildList(press: setIndex),
                      ),
                    ),
                  ),
              1: (BuildContext context) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 2.0),
                      child: ListView(
                        children: buildPantryItemList(pantryItems),
                      ),
                    ),
                  ),
              2: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByArea("Pantry"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              3: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByArea("Fridge"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              4: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByArea("Freezer"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              5: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Fruit and Vegetables"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              6: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Meat and Seafood"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              7: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Dairy"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              7: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Snacks"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              8: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Dry Items"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              9: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Spices"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              10: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Condiments"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
              11: (BuildContext context) => StreamBuilder(
                    stream: DatabaseService(uid: user.uid)
                        .streamPantryItemsByCategory("Other"),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data == null) return Loading();
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2.0),
                          child: ListView(
                            children: buildPantryItemList(data),
                          ),
                        ),
                      );
                    },
                  ),
            },
            fallbackBuilder: (BuildContext context) =>
                Text("None of the cases matched"),
          ),
          SizedBox(
            height: 23,
          ),
        ],
      ),
    );
  }

  List<Widget> buildList({Function press}) {
    List<Widget> list = List<Widget>.generate(
      subCategories.length,
      (index) => SubCategoryCard(
        subCategory: subCategories[index],
        press: () {
          press(5 + index);
        },
      ),
    );
    // list.add(
    //   AddNewCategory(
    //     press: press,
    //   ),
    // );
    return list;
  }

  List<Widget> buildPantryItemList(List<PantryItem> pantryItems) {
    List<Widget> pantryItemList = List<Widget>.generate(
      pantryItems.length,
      (index) => PantryItemCard(
        pantryItem: pantryItems[index],
      ),
    );

    return pantryItemList;
  }
}

class PantryItemCard extends StatelessWidget {
  const PantryItemCard({
    Key key,
    this.pantryItem,
  }) : super(key: key);

  final pantryItem;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Card(
        color: Colors.grey[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pantryItem.imgSrc ??
                        "https://drive.google.com/uc?id=1FXtI6_dvW_YjtRjN9B7qq3yNkweqMwfH"),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.defaultSize * 18,
              height: SizeConfig.defaultSize * 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pantryItem.label,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Amount: " + pantryItem.count.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Added: " +
                        DateFormat.yMMMd().format(pantryItem.date).toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  DatabaseService(uid: user.uid)
                      .deletePantryItem(pantryItem.id);
                }),
          ],
        ),
      ),
    );
  }
}
