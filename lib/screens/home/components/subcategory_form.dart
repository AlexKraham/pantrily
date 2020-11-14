import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/user.dart';
import 'package:pantrily/services/database.dart';
import 'package:pantrily/shared/constants.dart';
import 'package:pantrily/shared/loading.dart';
import 'package:pantrily/shared/size_config.dart';
import 'package:provider/provider.dart';

class SubCategoryForm extends StatefulWidget {
  @override
  _SubCategoryForm createState() => _SubCategoryForm();
}

class _SubCategoryForm extends State<SubCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentTitle;
  String _currentDescription;
  String _currentImgSrc;
  String _currentName;

  // when we don't need a provider, we can use a stream builder if we only care to have it in once class

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final defaultSize = SizeConfig.defaultSize;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // make sure we have data down the stream
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Create a new category',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      labelText: "Category Title",
                      labelStyle: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentTitle = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      labelText: "Description",
                      labelStyle: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) =>
                        setState(() => _currentDescription = val),
                  ),
                  SizedBox(height: 10.0),
                  FlatButton(
                      color: kPrimaryColor,
                      child: Text(
                        'Create Category',
                        style: TextStyle(
                            color: Colors.white, fontSize: defaultSize * 1.7),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print("Creating category");
                          await DatabaseService(uid: user.uid)
                              .createSubCategory(
                                  title: _currentTitle,
                                  description: _currentDescription,
                                  imgSrc: _currentImgSrc);
                          Navigator.pop(context);
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
