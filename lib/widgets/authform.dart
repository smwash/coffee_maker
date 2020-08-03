import 'package:coffee_maker/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthForm extends StatefulWidget {
  final void Function({
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  }) submitFn;
  final bool isLoading;
  final message;

  AuthForm({
    this.submitFn,
    this.isLoading,
    this.message,
  });
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _email;
  String _password;

  bool isLoggedIn = true;

  void submitForm() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      widget.submitFn(
        email: _email.trim(),
        password: _password.trim(),
        username: _username.trim(),
        isLogin: isLoggedIn,
        ctx: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(4, 4),
            spreadRadius: 4.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                isLoggedIn ? 'LogIn' : 'SignUp',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.0),
              if (!isLoggedIn)
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Username',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black54,
                    ),
                    helperText: 'Must be atleast 3 characters long',
                  ),
                  validator: (value) {
                    if (value.length < 3 || value.isEmpty) {
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value;
                  },
                ),
              SizedBox(height: 12.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.black54,
                  ),
                ),
                validator: (value) {
                  if (!value.contains('@') || value.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black54,
                  ),
                ),
                validator: (value) {
                  if (value.length < 7) {
                    return 'Password is too short';
                  }
                  if (value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 12.0),
              if (widget.isLoading)
                SpinKitThreeBounce(
                  color: Colors.brown[300],
                  size: 25.0,
                ),
              if (!widget.isLoading)
                RaisedButton(
                  child: Text(
                    isLoggedIn ? 'LogIn' : 'SignUp',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1),
                  ),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 35.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  color: Colors.brown[100],
                  onPressed: submitForm,
                ),
              SizedBox(height: 12.0),
              if (!widget.isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLoggedIn
                          ? 'Don\`t have an account?'
                          : 'I already have an account',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                    FlatButton(
                      child: Text(
                        isLoggedIn ? 'SignUp here' : 'Login here',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isLoggedIn = !isLoggedIn;
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
