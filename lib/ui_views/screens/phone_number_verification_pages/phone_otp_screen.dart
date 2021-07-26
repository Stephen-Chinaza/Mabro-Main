import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PhoneOtpScreen extends StatefulWidget {
  final String contact;
  final String phone;
  final String code;

  PhoneOtpScreen({Key key, this.contact, this.code, this.phone})
      : super(key: key);

  @override
  _PhoneOtpScreenState createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  String user;
  bool pageState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    user = (pref.getString('user') ?? '');
  }

  @override
  void initState() {
    super.initState();
    pageState = false;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: (pageState)
          ? loadingPage(state: pageState)
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dims.screenHeight(context) * 0.10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/mabrologo.jpg',
                          height: 110,
                          width: 110,
                        ),
                        SizedBox(
                          width: screenHeight * 0.01,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    TextStyles.textHeadings(
                      textColor: Colors.black,
                      textSize: 18,
                      textValue: 'Verification',
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    TextStyles.textDetails(
                      centerText: true,
                      textColor: Colors.black,
                      textSize: 14,
                      textValue:
                          'Enter A 6 digit number that was sent to ${widget.contact}',
                    ),
                    TextStyles.textSubHeadings(
                      textColor: Colors.black,
                      textSize: 14,
                      textValue: '${widget.code}',
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              screenWidth > 600 ? screenWidth * 0.2 : 4),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 2.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Container(
                            child: PinEntryTextField(
                              showFieldAsBox: false,
                              isTextObscure: true,
                              fields: 6,
                              onSubmit: (text) {
                                smsOTP = text as String;

                                sendPhone(text);
                              },
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          CustomButton(
                            onPressed: () {
                              kbackBtn(context);
                            },
                            text: 'Resend code',
                            disableButton: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void sendPhone(String text) async {
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['user'] = user;
      map['code'] = text;
      map['phone_number'] = widget.phone;

      var response = await http
          .post(HttpService.rootVerifyPhone, body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);

        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        RegisterUser verifyUser = RegisterUser.fromJson(body);

        bool status = verifyUser.status;
        String message = verifyUser.message;
        if (status) {
          cPageState(state: false);

          String blocked = verifyUser.data.blocked.toString();
          String phoneNumber = verifyUser.data.phoneNumber.toString();
          String phoneVerification = verifyUser.data.verifiedPhone.toString();

          SharedPrefrences.addStringToSP(
              "phone_verification", phoneVerification);
          SharedPrefrences.addStringToSP("phone_number", phoneNumber);
          SharedPrefrences.addStringToSP("blocked", blocked);

          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);

          _redirectuser();
        } else if (!status) {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
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
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void _redirectuser() {
    Future.delayed(Duration(seconds: 2), () {
      //kbackBtn(context);
      pushPage(context, LandingPage());
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message);
        break;
    }
  }

  void showAlertDialog(BuildContext context, String message) {
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
