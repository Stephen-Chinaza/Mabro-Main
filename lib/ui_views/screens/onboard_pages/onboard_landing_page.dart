import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/onboardinglayoutview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnBoardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: onBoradingBody(),
    );
  }
  Widget onBoradingBody() => Container(
        child: OnBoardingLayoutView(),
      );
}
