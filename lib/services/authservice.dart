import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/model/user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  var message = '';
  AuthResult authResult;
  FirebaseUser user;
  UserData currentuser;

  FirebaseUser current;
  String userUid;

  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future getCurrentUserID() async {
    final user = (await _auth.currentUser()).uid;
    userUid = user;
    notifyListeners();
  }

  Future getCurrentUser() async {
    final user = await _auth.currentUser();
    current = user;
    notifyListeners();
  }

//signIn with email and pass.
  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = authResult.user;

      return user;
    } on PlatformException catch (error) {
      if (error != null) {
        message = error.message;
      }
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

//signup and crating user in db,
  Future signUpWithEmailAndPassword(
      {String email, String password, String username}) async {
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'email': email,
        'username': username,
        'id': authResult.user.uid,
      });

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      _firestore.collection('coffee').document(currentUser.uid).setData({
        'id': currentUser.uid,
        'name': username,
        'sugars': '0',
        'strength': 100,
      });
    } on PlatformException catch (error) {
      if (error != null) {
        message = error.message;
      }
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
