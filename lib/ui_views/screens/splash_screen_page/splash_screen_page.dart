import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_up_page.dart';
import 'package:mabro/ui_views/screens/onboard_pages/onboard_landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool pageState = false;
  String pinState = '';

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool onboardState = (pref.getBool('isonBoardTrue') ?? false);
    pinState = (pref.getString('lock_code') ?? '');

    print(pinState);

    if (onboardState) {
      pageState = true;
    } else {
      pageState = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstScreen().then((value) => {
          setState(() {}),
        });
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => (pageState)
                  ? SignUpPage(
                      userPin: pinState,
                    )
                  : OnBoardingPage(userPin: pinState),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Center(
        child: Image.asset('assets/images/mabrologo.png'),
      ),
    );
  }
}
