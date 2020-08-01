import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/model/user.dart';
import 'package:coffee_maker/services/daatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  var message = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//signIn with email and pass.
  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
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
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'email': email,
        'username': username,
      });
      await Database(uid: authResult.user.uid)
          .updateUserData(name: username, sugars: '0', strength: 100);
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
