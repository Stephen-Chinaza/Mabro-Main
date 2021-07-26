import 'dart:async';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/screen_lock_page.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenLock extends StatefulWidget {
  bool isFirstScreen;
  @override
  _MainScreenLockState createState() => _MainScreenLockState();
}

class _MainScreenLockState extends State<MainScreenLock> {
  String userPin = '';
  bool pinState, checkPinState;

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pinState = (pref.getBool('pinState') ?? false);
    userPin = (pref.getString('lock_code') ?? '');
    if (pinState) {
      widget.isFirstScreen = true;
    } else {
      widget.isFirstScreen = false;
    }
    setState(() {});
  }

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = userPin == enteredPasscode;
    _verificationNotifier.add(isValid);
  }

  _isValidCallback() {
    _redirectuser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkFirstScreen();
    pinState = true;
    checkPinState = false;
  }

  @override
  Widget build(BuildContext context) {
    return (pinState)
        ? Scaffold(
            body: Stack(
              children: [
                PasscodeScreen(
                  title: Text('Enter fingerprint or pin',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  passwordEnteredCallback: _onPasscodeEntered,
                  isValidCallback: _isValidCallback,
                  cancelCallback: _isCancelCallback,
                  shouldTriggerVerification: _verificationNotifier.stream,
                  cancelButton: Text('Login'),
                  deleteButton: Text('Clear'),
                ),
                Visibility(
                    visible: checkPinState,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.8),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ))),
              ],
            ),
          )
        : LandingPage();
  }

  void _redirectuser() {
    checkPinState = true;
    Future.delayed(Duration(seconds: 3), () {
      checkPinState = false;
      pushPage(context, LandingPage());
    });
  }

  _isCancelCallback() {
    kopenPage(context, SignInPage());
  }
}
