import 'dart:io';

import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'verify_email_code_page.dart';

class SentEmailPage extends StatelessWidget {
  final String emailAddress;
  final String code;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SentEmailPage({Key key, this.emailAddress, this.code}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dims.sizedBoxHeight(height: 50),
                ),
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/images/email.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'A Verfication code has been sent to',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      emailAddress,
                      style: TextStyle(
                          fontSize: 14, color: ColorConstants.primaryColor),
                    ),
                    Text(
                      'Please check your mail to continue',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      code,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      margin: 0,
                      disableButton: true,
                      onPressed: () {
                        pushPage(
                          context,
                          EmailVerificationPage(emailAddress: emailAddress),
                        );
                      },
                      text: 'Continue'.toUpperCase()),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    openEmailApp(context);
                  },
                  child: Center(
                    child: Text(
                      'Check Mail'.toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }

  void openEmailApp(BuildContext context) {
    try {
      AppAvailability.launchApp(
              Platform.isIOS ? "message://" : "com.google.android.gm")
          .then((_) {
        print("App Email launched!");
      }).catchError((err) {
        ShowSnackBar.showInSnackBar(
            value: 'App Email not found!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      });
    } catch (e) {
      ShowSnackBar.showInSnackBar(
          value: 'Email App not found!',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }
}
