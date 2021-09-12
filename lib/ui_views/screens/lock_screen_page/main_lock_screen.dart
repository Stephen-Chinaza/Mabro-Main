import 'dart:async';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/screen_lock_page.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenLock extends StatefulWidget {
  final String userPin;

  const MainScreenLock({Key key, this.userPin}) : super(key: key);

  @override
  _MainScreenLockState createState() => _MainScreenLockState();
}

class _MainScreenLockState extends State<MainScreenLock> {

  bool pinState, checkPinState;
  bool isValid;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = widget.userPin == enteredPasscode;
    _verificationNotifier.add(isValid);
  }

  _isValidCallback() {
    _redirectuser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pinState = false;
    checkPinState = false;
    isValid = false;

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
            body: Stack(
              children: [
                PasscodeScreen(
                  title: Text('Enter fingerprint or pin'.toUpperCase(),
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: ColorConstants.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  passwordEnteredCallback: _onPasscodeEntered,
                  isValidCallback: _isValidCallback,
                  cancelCallback: _isCancelCallback,
                  shouldTriggerVerification: _verificationNotifier.stream,
                  cancelButton: Text('Login', style: TextStyle(color: ColorConstants.secondaryColor),),
                  deleteButton: Text('Clear', style: TextStyle(color: ColorConstants.secondaryColor)),
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
          );

  }

  void _redirectuser() {
    checkPinState = true;
    Future.delayed(Duration(seconds: 3), () {
      checkPinState = false;
      if(isValid){
        pushPage(context, LandingPage());
      }else{
        ShowSnackBar.showInSnackBar(
            value: 'Invalid Pin Entered',
            bgColor: ColorConstants.secondaryColor,
            context: context,
            scaffoldKey: _scaffoldKey);
      }
    });
  }

  _isCancelCallback() {
    kopenPage(context, SignInPage());
  }
}
