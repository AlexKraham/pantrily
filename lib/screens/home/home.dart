import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/brew.dart';
import 'package:pantrily/models/pantry.dart';
import 'package:pantrily/screens/home/brew_list.dart';
import 'package:pantrily/screens/home/list.dart';
import 'package:pantrily/screens/home/settings_form.dart';
import 'package:pantrily/services/auth.dart';
import 'package:pantrily/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider.value(
        value: DatabaseService().brews,
        child: Scaffold(
          backgroundColor: Colors.green[200],
          appBar: AppBar(
            title: Text("Pantrily"),
            backgroundColor: Colors.green[400],
            elevation: 0.0,
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("logout"),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text("settings"),
                onPressed: () => _showSettingsPanel(),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList(),
          ),
        ));
  }
}
