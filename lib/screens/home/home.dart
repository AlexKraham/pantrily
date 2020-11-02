import 'package:flutter/material.dart';
import 'package:pantrily/screens/home/list.dart';
import 'package:pantrily/services/auth.dart';
import 'package:pantrily/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().tests,
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
            ],
          ),
          body: List(),
        ));
  }
}
