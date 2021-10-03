import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/userInfo.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/screen_lock_page.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class MainScreenLock extends StatefulWidget {
  final String userPin;

  const MainScreenLock({Key key, this.userPin}) : super(key: key);

  @override
  _MainScreenLockState createState() => _MainScreenLockState();
}

class _MainScreenLockState extends State<MainScreenLock> {

  bool pinState, checkPinState;
  bool isValid;
  String userId;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  _onPasscodeEntered(String enteredPasscode) {
     isValid = widget.userPin == enteredPasscode;
    _verificationNotifier.add(isValid);

    setState(() {

    });
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
  }

  _isValidCallback() {
    _redirectuser();
    setState(() {});
  }

  _isFingerCallback() {
    isValid = true;
    _redirectuser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pinState = false;
    checkPinState = false;
    isValid = false;

    getData().whenComplete(() => {
    setState(() {})
    });

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
                  isFingerValidCallback: _isFingerCallback,
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
      setState(() {
        print(isValid);
        print('isValid');
        if(isValid){
          getUserInfo();
        }else{
          ShowSnackBar.showInSnackBar(
              value: 'Invalid Pin Entered',
              bgColor: ColorConstants.secondaryColor,
              context: context,
              scaffoldKey: _scaffoldKey);
        }
      });

    });
  }

  _isCancelCallback() {
    kopenPage(context, SignInPage());
  }

  void _userInfo() async {
    String message;
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http
          .post(HttpService.rootUserInfo, body: map, headers: {
        'Authorization': 'Bearer '+HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {

        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            bgColor: ColorConstants.secondaryColor,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        UserInfo userInfo = UserInfo.fromJson(body);

        bool status = userInfo.status;
        message = userInfo.message;


        if (status) {

          userId = userInfo.data.bvns.user;

          String accountName = userInfo.data.account.accountName.toString();
          String accountNumber = userInfo.data.account.accountNumber.toString();
          String bankName = userInfo.data.account.bankName.toString();
          String firstName = userInfo.data.bvns.firstName.toString();
          String surName = userInfo.data.bvns.surname.toString();
          String bvn = userInfo.data.bvns.bvn.toString();

          String emailTransactionNotification = userInfo.data.settings.emailTransactionNotification.toString();
          String smsNotification = userInfo.data.settings.smsNotification.toString();
          String twoFactorAuthentication = userInfo.data.settings.twoFactorAuthentication.toString();
          String fingerPrintLogin = userInfo.data.settings.fingerPrintLogin.toString();
          String newsletter = userInfo.data.settings.newsletter.toString();


          SharedPrefrences.addStringToSP("userId", userId);

          SharedPrefrences.addStringToSP("account_name", accountName);
          SharedPrefrences.addStringToSP("account_number", accountNumber);
          SharedPrefrences.addStringToSP("bank_name", bankName);
          SharedPrefrences.addStringToSP("bvn", bvn);
          SharedPrefrences.addStringToSP("first_name", firstName);
          SharedPrefrences.addStringToSP("surname", surName);


          SharedPrefrences.addStringToSP("sms_notification", smsNotification);
          SharedPrefrences.addStringToSP("email_transaction_notification", emailTransactionNotification);
          SharedPrefrences.addStringToSP("two_factor_authentication", twoFactorAuthentication);
          SharedPrefrences.addStringToSP("finger_print_login", fingerPrintLogin);
          SharedPrefrences.addStringToSP("newsletter", newsletter);


          ShowSnackBar.showInSnackBar(
              value: 'authentication successful',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          Future.delayed(Duration(seconds: 2), () {
            pushPage(context, LandingPage());


          });
        } else if (!status) {

          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {

        ShowSnackBar.showInSnackBar(
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {

      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void getUserInfo(){
    ShowSnackBar.showInSnackBar(
        value: 'authentication successful',
        context: context,
        scaffoldKey: _scaffoldKey,
        timer: 5);
    Future.delayed(Duration(seconds: 2), () {
      pushPage(context, LandingPage());

     // _userInfo();
    });
  }

  void openPage(){
    Future.delayed(Duration(seconds: 2), () {
      ShowSnackBar.showInSnackBar(
          value: 'authentication successful',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
      pushPage(context, LandingPage());

      // _userInfo();
    });
  }
}
