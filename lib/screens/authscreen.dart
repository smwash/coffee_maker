import 'package:coffee_maker/services/authservice.dart';
import 'package:coffee_maker/widgets/authform.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  var message = '';
  AuthService _auth = AuthService();

  void _submitAuthFn({
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  }) async {
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await _auth.signUpWithEmailAndPassword(
            email: email, password: password, username: username);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: AuthForm(
          submitFn: _submitAuthFn,
          message: message,
          isLoading: isLoading,
        ),
      ),
    );
  }
}
