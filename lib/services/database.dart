import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference testCollection =
      FirebaseFirestore.instance.collection('tests');

  Future updateUserData(String sugars, String name, int strength) async {
    return await testCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Stream<QuerySnapshot> get tests {
    return testCollection.snapshots();
  }
}
