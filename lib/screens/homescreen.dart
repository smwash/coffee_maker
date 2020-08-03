import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/model/user.dart';

import 'package:coffee_maker/services/authservice.dart';
import 'package:coffee_maker/services/daatabase.dart';

import 'package:coffee_maker/widgets/coffeetile.dart';
import 'package:coffee_maker/widgets/loading.dart';
import 'package:coffee_maker/widgets/settingsform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettings() {
      showModalBottomSheet(
          context: (context),
          builder: (context) {
            return Container(
              child: SettingsForm(),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        //centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Coffee Maker',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _showSettings,
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AuthService _auth = AuthService();
              _auth.signOut();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/coffee_bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('coffee').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final coffee = snapshot.data.documents[index];
                    return CoffeeTile(userCoffee: coffee);
                  });
            }),
      ),
    );
  }
}

// class SetCoffeeData extends StatefulWidget {
//   @override
//   _SetCoffeeDataState createState() => _SetCoffeeDataState();
// }

// class _SetCoffeeDataState extends State<SetCoffeeData> {
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<AuthService>(context);
//     final current = userProvider.getCurrentUser();

//     final user = userProvider.getCurrentUserID();

//     final userId = userProvider.current;
//     final uid = userId.uid;
//     return StreamBuilder(
//         stream:
//             Firestore.instance.collection('coffee').document(uid).snapshots(),
//         builder: (context, snapshot) {
//           //print(snapshot.data['strength']);

//           return Text('${snapshot.data['name']}');
//         });
//   }
// }
