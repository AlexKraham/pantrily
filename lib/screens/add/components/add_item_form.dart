import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/FoodItem.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/screens/home/components/success_add_item.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/loading.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class AddItemForm extends StatefulWidget {
  final FoodItem foodItem;
  AddItemForm({Key key, this.foodItem}) : super(key: key);
  @override
  _AddItemForm createState() => _AddItemForm(foodItem);
}

class _AddItemForm extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  _AddItemForm(this.foodItem);

  FoodItem foodItem;

  // form values
  String _currentTitle;
  String _currentDescription;
  String _currentImgSrc;
  String _currentArea;
  int _currentCount;

  final List<String> areas = ["Pantry", "Fridge", "Freezer"];

  // when we don't need a provider, we can use a stream builder if we only care to have it in once class

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final defaultSize = SizeConfig.defaultSize;
    bool loading = false;
    bool success = false;

    void addItem() async {
      setState(() {
        loading = true;
      });
      await DatabaseService(uid: user.uid).addPantryItem(
        foodId: foodItem.foodId,
        label: foodItem.label,
        imgSrc: foodItem.imgSrc,
        category: foodItem.category,
        area: _currentArea,
        count: _currentCount,
      );
      // Navigator.pop(context);
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // make sure we have data down the stream
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: loading
                  ? Loading()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Adding Item To Pantry",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(foodItem.imgSrc ??
                                      "https://drive.google.com/uc?id=1FXtI6_dvW_YjtRjN9B7qq3yNkweqMwfH"),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  StringUtils.capitalize(foodItem.label ?? ""),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.end,
                                ),
                                Text(
                                  foodItem.category ?? "",
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Select Area",
                          ),
                          items: areas.map((area) {
                            return DropdownMenuItem(
                              value: area,
                              child: Text('$area'),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _currentArea = val),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "Select Amount",
                              labelStyle: TextStyle(
                                color: kPrimaryColor,
                              ),
                              hoverColor: kPrimaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                              focusColor: kPrimaryColor,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (val) =>
                                setState(() => _currentCount = int.parse(val))),
                        SizedBox(height: 10.0),
                        FlatButton(
                            color: kPrimaryColor,
                            child: Text(
                              'Add Item To Pantry',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: defaultSize * 1.7),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                addItem();
                              }
                            }),
                      ],
                    ),
            );
          } else {
            return Loading();
          }
        });
  }
}
