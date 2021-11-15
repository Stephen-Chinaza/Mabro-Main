import 'package:flutter/gestures.dart';
import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/account_page.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  String userId;
  bool pageState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
  }

  @override
  void initState() {
    super.initState();
    pageState = false;
    getUserData();

    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                height: 20,
              ),
              Image.asset(
                'assets/images/registration.png',
                height: 100,
                width: 160,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              TextStyles.textDetails(
                centerText: true,
                textColor: ColorConstants.whiteLighterColor,
                textSize: 14,
                textValue:
                    'Enter A 6 digit number that was sent to ${widget.contact}',
              ),
              TextStyles.textSubHeadings(
                textColor: ColorConstants.whiteLighterColor,
                textSize: 14,
                textValue: '${widget.code}',
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: ColorConstants.primaryLighterColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Visibility(
                      visible: !pageState,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10),
                                child: PinCodeTextField(
                                  appContext: context,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 6,
                                  obscureText: true,
                                  animationType: AnimationType.fade,
                                  validator: (v) {
                                    if (v.length < 6) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  pinTheme: PinTheme(
                                    activeColor: ColorConstants.secondaryColor,
                                    inactiveColor:
                                        ColorConstants.secondaryColor,
                                    selectedColor:
                                        ColorConstants.secondaryColor,
                                    shape: PinCodeFieldShape.box,
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    activeFillColor:
                                        hasError ? Colors.orange : Colors.white,
                                  ),
                                  cursorColor: Colors.white,
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  textStyle: TextStyle(
                                      fontSize: 26,
                                      height: 1.6,
                                      color: ColorConstants.white),
                                  backgroundColor: ColorConstants.transparent,
                                  obscuringCharacter: '*',
                                  enableActiveFill: false,
                                  errorAnimationController: errorController,
                                  controller: textEditingController,
                                  keyboardType: TextInputType.number,
                                  boxShadows: [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      color: Colors.black12,
                                      blurRadius: 10,
                                    )
                                  ],
                                  onCompleted: (v) {
                                    print(v);

                                    formKey.currentState.validate();

                                    if (currentText.length != 6) {
                                    } else {
                                      setState(() {
                                        hasError = false;
                                        textEditingController.text = '';
                                        sendPhone(v);
                                      });
                                    }
                                  },
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      currentText = value;
                                    });
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");

                                    return true;
                                  },
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              hasError
                                  ? "*Please fill up all the cells properly"
                                  : "",
                              style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: Dims.sizedBoxHeight(height: 10.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              reSendPhone();
                            },
                            child: TextStyles.textHeadings(
                                textValue: 'RESEND CODE',
                                textSize: 14.0,
                                textColor: ColorConstants.whiteLighterColor),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
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
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                  ],
                ),
              ),
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
      map['userId'] = userId;
      map['phone_number'] = widget.phone;
      map['otp'] = text;

      var response =
          await http.post(HttpService.rootVerifyPhone, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
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
          //cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);

          SharedPrefrences.addStringToSP("phone_number", widget.phone);

          pushPage(context, AccountPage());

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

  void reSendPhone() async {
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map['phone_number'] = widget.phone;

      var response =
          await http.post(HttpService.rootResendPhone, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
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

          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
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
