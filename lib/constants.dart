import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.black87,
      width: 1.2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12.0),
    ),
    borderSide: BorderSide(
      color: Colors.black26,
    ),
  ),
);
