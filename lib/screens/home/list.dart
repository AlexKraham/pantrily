import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    final tests = Provider.of<QuerySnapshot>(context);
    // print(tests.documents);
    for (var doc in tests.docs) {
      print(doc.data());
    }
    return Container();
  }
}
