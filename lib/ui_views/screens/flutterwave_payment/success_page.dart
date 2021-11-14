import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'Transaction status',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 600,
            child: Card(
              color: ColorConstants.primaryLighterColor,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Stack(
                      children: [
                        SucessContainer(
                            color: Colors.green.withOpacity(0.4),
                            width: 180,
                            height: 180,
                            shadowColor: Colors.green.withOpacity(0.2)),
                        SucessContainer(
                            color: Colors.green.withOpacity(0.6),
                            width: 160,
                            height: 160,
                            left: 4.0,
                            top: 40),
                        SucessContainer(
                            color: Colors.green.withOpacity(0.9),
                            width: 140,
                            height: 140,
                            left: 3.6,
                            top: 40),
                        Positioned(
                            top: 105,
                            left: MediaQuery.of(context).size.width / 2.9,
                            child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.check,
                                    color: Colors.white, size: 80)))
                      ],
                    ),
                  ),
                  Text(
                    'Transaction Successful'.toUpperCase(),
                    style: TextStyle(fontSize: 16, color: ColorConstants.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your transaction is successful and your account has been credited',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.whiteLighterColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      margin: 10,
                      height: 40,
                      disableButton: true,
                      onPressed: () {
                        kopenPage(context, LandingPage());
                      },
                      text: 'Continue'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SucessContainer extends StatelessWidget {
  final Color color, shadowColor;
  final double height, width, top, left;
  final String scoreText, score;

  const SucessContainer(
      {Key key,
      this.color,
      this.height,
      this.width,
      this.top,
      this.left,
      this.scoreText = '',
      this.score = '',
      this.shadowColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: shadowColor, spreadRadius: 6)
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(scoreText, style: TextStyle(fontSize: 18)),
                  Text(score, style: TextStyle(fontSize: 14)),
                ],
              ),
            )),
      ),
    );
  }
}
