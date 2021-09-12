import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingPage({bool state = false}) {
  return Visibility(
    visible: state,
    child: Container(
      color: ColorConstants.primaryColor,
      child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)),
    ),
  );
}
