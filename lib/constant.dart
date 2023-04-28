import 'package:flutter/material.dart';

const kInputTextFieldDecoration = InputDecoration(
  hintText: 'please enter the text you want to encrypt',
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
