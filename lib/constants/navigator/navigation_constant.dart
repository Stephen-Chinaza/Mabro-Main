
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


kopenPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}

kbackBtn(BuildContext context) {
  Navigator.pop(context);
}

pushPage(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

