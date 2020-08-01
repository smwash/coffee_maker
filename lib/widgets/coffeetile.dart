import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final DocumentSnapshot userCoffee;

  CoffeeTile({this.userCoffee});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ListTile(
        tileColor: Colors.grey[300],
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: AssetImage(
            'assets/images/coffee_icon.png',
          ),
          backgroundColor: Colors.brown[userCoffee['strength']],
        ),
        title: Text(
          userCoffee['name'],
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${userCoffee['sugars']} sugar(s)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
