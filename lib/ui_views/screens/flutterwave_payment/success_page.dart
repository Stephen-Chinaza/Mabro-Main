import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

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
        child: Column(
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  SucessContainer(
                      color: ColorConstants.primaryColor.withOpacity(0.4),
                      width: 200,
                      height: 200,
                      shadowColor:
                          ColorConstants.primaryColor.withOpacity(0.2)),
                  SucessContainer(
                      color: ColorConstants.primaryColor.withOpacity(0.6),
                      width: 180,
                      height: 180,
                      left: 4.0,
                      top: 90),
                  SucessContainer(
                      color: ColorConstants.primaryColor.withOpacity(0.9),
                      width: 160,
                      height: 160,
                      left: 3.6,
                      top: 100),
                  Positioned(
                      top: 100,
                      left: MediaQuery.of(context).size.width / 2.7,
                      child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.check,
                              color: Colors.white, size: 100)))
                ],
              ),
            ),
            Text(
              'Transaction Successful!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: Dims.screenHeight(context) * 0.2,
            ),
            Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SucessContainer(
                          color: ColorConstants.primaryColor.withOpacity(0.4),
                          width: 70,
                          height: 70,
                          left: 2.95,
                          top: 80,
                          shadowColor:
                              ColorConstants.primaryColor.withOpacity(0.2)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
