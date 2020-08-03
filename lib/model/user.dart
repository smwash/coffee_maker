class User {
  String uid;
  User({this.uid});
}

class UserData {
  String uid;
  String name;
  String sugars;
  int strength;

  UserData({this.sugars, this.strength, this.name, this.uid});

  // factory UserData.fromDocument(DocumentSnapshot doc) {
  //   return UserData(
  //     uid: doc['uid'],
  //     name: doc['name'],
  //     sugars: doc['sugars'],
  //     strength: doc['strength'],
  //   );
  // }
}
