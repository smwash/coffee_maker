import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/model/user.dart';
import 'package:coffee_maker/services/daatabase.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentname;
  String _currentsugars;
  String _currentstrength;

  User user = User();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Container();
        });
  }
}
