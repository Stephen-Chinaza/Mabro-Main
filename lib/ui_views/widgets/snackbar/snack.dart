import 'package:mabro/res/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showInSnackBar(
      {String value,
      Color bgColor = ColorConstants.secondaryColor,
      Color leftBarColor = Colors.green,
      int timer = 3,
      IconData iconData = Icons.info_outline,
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey}) {
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.all(8.0),
          message: value,
          reverseAnimationCurve: Curves.easeOut,
          forwardAnimationCurve: Curves.easeIn,
          backgroundColor: bgColor,
          borderRadius: 15,
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          icon: Icon(
            iconData,
            size: 28.0,
            color: Colors.white,
          ),
          duration: Duration(seconds: timer),
        )..show(context),
      ),
    );
  }

  static void customSnackBar(
      {String value,
      String title = 'Message',
      String btnText = 'Continue',
      Color bgColor = ColorConstants.secondaryColor,
      Function onTapped,
      int timer = 3,
      FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
      IconData iconData = Icons.info_outline,
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey}) {
    Flushbar(
      title: title,
      message: value,
      flushbarPosition: flushbarPosition,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: bgColor,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      reverseAnimationCurve: Curves.easeOut,
      forwardAnimationCurve: Curves.easeIn,
      duration: Duration(seconds: timer),
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 22,
      ),
      mainButton: TextButton(
        onPressed: onTapped,
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white),
        ),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        value,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    )..show(context);
  }
}
