import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shapes {
  static ShapeBorder kBackButtonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(30),
    ),
  );

  static var kTextFieldDecoration = InputDecoration(
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
     
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  );

   static var textFieldDecoration = InputDecoration(
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              topLeft: Radius.circular(4),
            ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              topLeft: Radius.circular(4),
            ),
      
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              topLeft: Radius.circular(4),
            ),
      
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              topLeft: Radius.circular(4),
            ),
    ),
    hintStyle: TextStyle(height: 1.5, fontSize: 14),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  );
}
