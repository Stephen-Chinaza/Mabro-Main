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
import 'package:mabro/ui_views/screens/password_setting/set_password_page.dart';
import 'package:mabro/core/models/login_user.dart';

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
  String _email;
  String _password;
  String _lockCode;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  _onPasscodeEntered(String enteredPasscode) {
    isValid = widget.userPin == enteredPasscode;
    _verificationNotifier.add(isValid);

    setState(() {});
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    _email = (pref.getString('email_address') ?? '');
    _password = (pref.getString('password') ?? '');
    _lockCode = (pref.getString('lock_code') ?? '');
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
          setState(() {
            print(widget.userPin);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            cancelButton: Text(
              'Login',
              style: TextStyle(color: ColorConstants.secondaryColor),
            ),
            deleteButton: Text('Clear',
                style: TextStyle(color: ColorConstants.secondaryColor)),
          ),
          Visibility(
              visible: checkPinState,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
        if (isValid) {
          _signIn();
        } else {
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

  void _signIn() async {
    try {
      var map = Map<String, dynamic>();
      map['email_address'] = _email;
      map['password'] = _password;

      var response =
          await http.post(HttpService.rootLogin, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'The connection has timed out, please try again!',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5,
        );

        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        LoginUser loginUser = LoginUser.fromJson(body);

        bool status = loginUser.status;
        String message = loginUser.message;
        if (status) {
          String verifiedEmail = loginUser.data.verifiedEmail.toString();
          String blocked = loginUser.data.blocked.toString();
          String lockCode = loginUser.data.lockCode;

          //TODO CHECK IF USER IS BLOCKED OR LOCK_CODE IS SET
          if (verifiedEmail == '1') {
            if (lockCode == '') {
              ShowSnackBar.showInSnackBar(
                  bgColor: ColorConstants.secondaryColor,
                  value: 'User lock code not set',
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  timer: 5);
              Future.delayed(Duration(seconds: 5), () {
                pushPage(context, SetPinPage());
              });
            } else {
              if (blocked == '1') {
                ShowSnackBar.showInSnackBar(
                    bgColor: ColorConstants.secondaryColor,
                    value: 'User is currently blocked',
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    timer: 5);
              } else {
                String firstName = loginUser.data.firstName;
                String surName = loginUser.data.surname;
                String phone = loginUser.data.phoneNumber;
                String id = loginUser.data.id.toString();
                String userId = loginUser.data.userId.toString();
                String email = loginUser.data.emailAddress;
                String lockCode = loginUser.data.lockCode;
                String nairaBalance = loginUser.data.nairaBalance.toString();
                String verifiedEmail = loginUser.data.verifiedEmail.toString();
                String verifiedPhone = loginUser.data.verifiedPhone.toString();
                String accountNumber = loginUser.data.nairaWallet.accountNumber;
                String accountName = loginUser.data.nairaWallet.accountName;
                String bankName = loginUser.data.nairaWallet.bank;
                String bitcoinBalance =
                    loginUser.data.bitcoin.balance.toString();
                String bitcoinAddress = loginUser.data.bitcoin.address;
                String litecoinBalance =
                    loginUser.data.litecoin.balance.toString();
                String litecoinAddress = loginUser.data.litecoin.address;
                String dogecoinBalance =
                    loginUser.data.dogecoin.balance.toString();
                String dogecoinAddress = loginUser.data.dogecoin.address;

                SharedPrefrences.addStringToSP("lock_code", lockCode);
                SharedPrefrences.addStringToSP("surname", surName);
                SharedPrefrences.addStringToSP("nairaBalance", nairaBalance);
                SharedPrefrences.addStringToSP("account_number", accountNumber);
                SharedPrefrences.addStringToSP("account_name", accountName);
                SharedPrefrences.addStringToSP("bank", bankName);
                SharedPrefrences.addStringToSP(
                    "bitcoin_balance", bitcoinBalance);
                SharedPrefrences.addStringToSP(
                    "bitcoin_address", bitcoinAddress);
                SharedPrefrences.addStringToSP(
                    "litecoin_balance", litecoinBalance);
                SharedPrefrences.addStringToSP(
                    "litecoin_address", litecoinAddress);
                SharedPrefrences.addStringToSP(
                    "dogecoin_balance", dogecoinBalance);
                SharedPrefrences.addStringToSP(
                    "litecoin_address", dogecoinAddress);

                SharedPrefrences.addStringToSP("first_name", firstName);
                SharedPrefrences.addStringToSP("phone_number", phone);
                SharedPrefrences.addStringToSP("id", id);
                SharedPrefrences.addStringToSP("userId", userId);
                SharedPrefrences.addStringToSP("email_address", email);
                SharedPrefrences.addStringToSP("blocked", blocked);
                SharedPrefrences.addStringToSP("verified_email", verifiedEmail);
                SharedPrefrences.addStringToSP("verified_phone", verifiedPhone);

                ShowSnackBar.showInSnackBar(
                  value: message,
                  iconData: Icons.check_circle,
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  timer: 5,
                );
                getUserInfo();
              }
            }
          } else {
            ShowSnackBar.showInSnackBar(
                value: 'Please verify your email',
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.secondaryColor,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void getUserInfo() {
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

  void openPage() {
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
