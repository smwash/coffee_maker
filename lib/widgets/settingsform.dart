import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/constants.dart';
import 'package:coffee_maker/model/user.dart';
import 'package:coffee_maker/services/authservice.dart';
import 'package:coffee_maker/services/daatabase.dart';
import 'package:coffee_maker/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentname;
  String _currentsugars;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthService>(context);
    var user1 = userProvider.getCurrentUser();
    var user = userProvider.current;

    return StreamBuilder(
        stream: Firestore.instance
            .collection('coffee')
            .document(user.uid)
            .snapshots(),
        //Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          var userdata = snapshot.data;
          return Container(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 20.0,
              right: 20.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Coffee Settings',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      initialValue: snapshot.data['name'],
                      //userdata['name'],
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Username',
                        helperText: 'Must be atleaast 3 characters',
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 3) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _currentname = value;
                      },
                    ),
                    DropdownButtonFormField(
                      value: _currentsugars ?? userdata['sugars'],
                      decoration: kTextFieldDecoration,
                      items: sugars.map(
                        (sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        },
                      ).toList(),
                      onChanged: (value) => setState(
                        () => _currentsugars = value,
                      ),
                    ),
                    Slider(
                      value:
                          (_currentstrength ?? userdata['strength']).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      activeColor: Colors
                          .brown[_currentstrength ?? userdata['strength']],
                      inactiveColor: Colors
                          .brown[_currentstrength ?? userdata['strength']],
                      onChanged: (value) =>
                          setState(() => _currentstrength = value.round()),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.brown[200],
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        //final user = Provider.of<AuthService>(context).current;
                        FocusScope.of(context).unfocus();

                        final isValid = _formKey.currentState.validate();
                        if (isValid) {
                          _formKey.currentState.save();
                          await Database(uid: user.uid).updateUserData(
                            name: _currentname ?? snapshot.data['name'],
                            sugars: _currentsugars ?? snapshot.data['sugars'],
                            strength:
                                _currentstrength ?? snapshot.data['strength'],
                          );

                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
