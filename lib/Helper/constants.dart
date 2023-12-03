import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your message/question',
  hintStyle: TextStyle(color: Colors.white70),
  // hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(35.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0x8C5D23B8)),
    borderRadius: BorderRadius.all(Radius.circular(35.0)),
  ),
);

TextStyle content = const TextStyle(fontSize: 14, color: Colors.white70);
TextStyle headingStyle = const TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey);

const userArtLinks = ['1', '2', '3', '4', '5', '6', '7', '8'];
