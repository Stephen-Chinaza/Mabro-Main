import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/phone_number_verification_pages/phone_otp_screen.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/country_picker/country_picker.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPhoneNScreen extends StatefulWidget {
  @override
  _ConfirmPhoneNScreenState createState() => _ConfirmPhoneNScreenState();
}

class _ConfirmPhoneNScreenState extends State<ConfirmPhoneNScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _contactEditingController = TextEditingController();
  var _dialCode = '';
  String userId;
  bool pageState;
  int inputNum;

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    inputNum = 0;
    pageState = false;
  }

  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dims.screenHeight(context) * 0.11,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextStyles.textDetails(
                        centerText: true,
                        textSize: 20,
                        textColor: ColorConstants.secondaryColor,
                        textValue: 'Phone Number Verification',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/registration.png',
                  height: 130,
                  width: 190,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextStyles.textDetails(
                    centerText: true,
                    textSize: 16,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue:
                        'Enter your mobile number to receive a verification code',
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: ColorConstants.primaryLighterColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Visibility(
                        visible: !pageState,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstants.whiteColor,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  CountryPicker(
                                    callBackFunction: _callBackFunction,
                                    headerText: 'Select Country',
                                    headerBackgroundColor:
                                        ColorConstants.primaryColor,
                                    headerTextColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.01,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      cursorColor:
                                          ColorConstants.secondaryColor,
                                      style: TextStyle(
                                          color: ColorConstants.white),
                                      decoration: const InputDecoration(
                                        hintText: 'Contact Number',
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: ColorConstants
                                                .whiteLighterColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 13.5),
                                      ),
                                      controller: _contactEditingController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      onChanged: (String input) {
                                        setState(() {
                                          inputNum = input.length;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomButton(
                              onPressed: () {
                                clickOnLogin(context);
                              },
                              text: 'Send otp',
                              disableButton: true,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: pageState,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'verifying code...',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> clickOnLogin(BuildContext context) async {
    if (_contactEditingController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          context: context,
          timer: 5,
          value: 'Phone enter phone number to continue');
    } else if (inputNum < 10) {
      ShowSnackBar.showInSnackBar(
          context: context, timer: 5, value: 'incorrect phone number');
    } else {
      sendNumber();
    }
  }

  void sendNumber() async {
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map['phone_number'] = '0' + _contactEditingController.text;

      print('0' + _contactEditingController.text);

      var response =
          await http.post(HttpService.rootSendPhone, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
          value: 'The connection has timed out, please try again!',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5,
        );

        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        RegisterUser verifyPhone = RegisterUser.fromJson(body);

        bool status = verifyPhone.status;
        String message = verifyPhone.message;
        if (status) {
          cPageState(state: false);

          String otp = verifyPhone.data.oTP;
          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          _redirectuser(code: otp);
        } else if (!status) {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
            value: message,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5,
          );
        }
      } else {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      cPageState(state: false);
      ShowSnackBar.showInSnackBar(
          value: 'Please check internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5,
          bgColor: Colors.green);
    }
  }

  void _redirectuser({String code}) {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 2), () {
      pushPage(
          context,
          PhoneOtpScreen(
              contact: '$_dialCode${_contactEditingController.text}',
              phone: '0' + _contactEditingController.text,
              code: code));
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void showErrorDialog(BuildContext context, String message) {
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
