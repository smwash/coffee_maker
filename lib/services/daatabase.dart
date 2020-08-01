import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/model/coffee_model.dart';
import 'package:coffee_maker/model/user.dart';

class Database {
  final String uid;

  Database({this.uid});

  final CollectionReference coffeeCollection =
      Firestore.instance.collection('coffee');

//updating user data;
  Future<void> updateUserData(
      {String name, String sugars, int strength}) async {
    return await coffeeCollection.document(uid).setData({
      'name': name,
      'sugars': sugars,
      'strength': strength,
    });
  }

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Coffee(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Coffee>> get coffeeList {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  Stream<UserData> get userData {
    return coffeeCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
