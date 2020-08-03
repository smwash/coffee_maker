import 'package:coffee_maker/screens/homescreen.dart';
import 'package:coffee_maker/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/authscreen.dart';
import 'widgets/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffe maker',
        theme: ThemeData(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              if (snapshot.hasData) {
                return HomePage();
              }
              return AuthScreen();
            }),
      ),
    );
  }
}
