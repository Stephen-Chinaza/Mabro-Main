import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildFirstContainer() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.white,
    child: Center(
        child: Image.asset('assets/images/mbl1.jpg', height: 300, width: 350)),
  );
}

Widget buildSecondContainer() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.white,
  );
}
