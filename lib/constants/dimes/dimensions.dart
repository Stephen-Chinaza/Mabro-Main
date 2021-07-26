import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dims {
  static leftPadding({double value = 16.0}) {
    return EdgeInsets.only(left: value);
  }

  static rightPadding({double value = 16.0}) {
    return EdgeInsets.only(right: value);
  }

  static topPadding({double value = 16.0}) {
    return EdgeInsets.only(top: value);
  }

  static bottomPadding({double value = 16.0}) {
    return EdgeInsets.only(bottom: value);
  }

  static allPadding({double value = 16.0}) {
    return EdgeInsets.all(value);
  }

  static allRooundDiffPadding(
      {double leftValue,
      double topValue,
      double rightValue,
      double bottomValue}) {
    return EdgeInsets.fromLTRB(leftValue, topValue, rightValue, bottomValue);
  }

  static horizontalPadding({double value = 16.0}) {
    return EdgeInsets.symmetric(horizontal: value);
  }

  static verticalPadding({double value = 16.0}) {
    return EdgeInsets.symmetric(vertical: value);
  }

  static leftMargin({double value = 16.0}) {
    return EdgeInsets.only(left: value);
  }

  static rightMargin({double value = 16.0}) {
    return EdgeInsets.only(right: value);
  }

  static topMargin({double value = 16.0}) {
    return EdgeInsets.only(top: value);
  }

  static bottomMargin({double value = 16.0}) {
    return EdgeInsets.only(bottom: value);
  }

  static allMargin({double value = 16.0}) {
    return EdgeInsets.all(value);
  }

  static allRooundDiffMargin(double leftValue, double topValue,
      double rightValue, double bottomValue) {
    return EdgeInsets.fromLTRB(leftValue, topValue, rightValue, bottomValue);
  }

  static horizontalMargin({double value = 16.0}) {
    return EdgeInsets.symmetric(horizontal: value);
  }

  static verticalMargin({double value = 16.0}) {
    return EdgeInsets.symmetric(vertical: value);
  }

  static double sizedBoxHeight({double height = 20}) {
    return height;
  }

  static double sizedBoxWidth({double height = 20}) {
    return height;
  }

  static screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight;
  }

  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
