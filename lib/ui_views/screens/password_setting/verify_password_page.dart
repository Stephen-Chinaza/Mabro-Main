import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/email_verification_data.dart.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

// ignore: must_be_immutable
class VerifyPinPage extends StatefulWidget {
  final String textPin;

  VerifyPinPage({Key key, this.textPin}) : super(key: key);
  @override
  _VerifyPinPageState createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  String confirmText;

  bool pageState, checkState;
  String userId;


  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";

  final formKey = GlobalKey<FormState>();
  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
  }

  @override
  void initState() {
    super.initState();

    pageState = false;
    checkState = false;

    confirmText = '';
    checkFirstScreen();

    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorConstants.primaryColor,
          body:  SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Expanded(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: Dims.sizedBoxHeight(height: 50),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          GestureDetector(
                              onTap: () {}, child: _buildSecurityText()),
                          SizedBox(
                            height: Dims.sizedBoxHeight(
                                height:
                                Dims.screenHeight(context) * 0.10),
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
                                          vertical: 4.0, horizontal: 40),
                                      child: PinCodeTextField(
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        length: 4,
                                        obscureText: true,

                                        validator: (v) {
                                          if (v.length < 4) {
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          fieldHeight: 50,
                                          fieldWidth: 50,
                                          activeFillColor:
                                          hasError ? Colors.orange : Colors.white,
                                        ),
                                        cursorColor: Colors.white,
                                        animationDuration: Duration(milliseconds: 300),
                                        textStyle: TextStyle(fontSize: 26, height: 1.6, color: ColorConstants.white),
                                        backgroundColor: ColorConstants.transparent,
                                        obscuringCharacter: '*',
                                        enableActiveFill: false,

                                        controller: textEditingController,
                                        keyboardType: TextInputType.number,

                                        onCompleted: (v) {
                                          print(v);

                                          formKey.currentState.validate();
                                          // conditions for validating
                                          if (currentText.length != 4) {

                                          } else {
                                            if (v == widget.textPin) {
                                              setState(() {
                                                hasError = false;
                                                textEditingController
                                                    .text = '';
                                                _setPin(v);
                                              });
                                            }else{
                                              ShowSnackBar.showInSnackBar(
                                                  bgColor: ColorConstants.secondaryColor,
                                                  value: 'Pin mismatch re-enter pin',
                                                  context: context,
                                                  scaffoldKey: _scaffoldKey,
                                                  timer: 5);
                                              textEditingController
                                                  .text = '';
                                              Future.delayed(Duration(seconds: 3), (){
                                                kbackBtn(context);

                                              });
                                            }
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
                                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                          return true;
                                        },
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    hasError ? "*Please fill up all the cells properly" : "",
                                    style: TextStyle(
                                        color: ColorConstants.secondaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                                SizedBox(
                                  height: Dims.sizedBoxHeight(height: 30.0),
                                ),
                                GestureDetector(onTap: (){
                                  kbackBtn(context);
                                },
                                  child: TextStyles.textHeadings(
                                      textValue: 'BACK',
                                      textSize: 16.0,
                                      textColor: ColorConstants.whiteLighterColor
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Visibility(
                            visible: pageState,
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                                SizedBox(height: 20),
                                Text('verifying code...', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
                              ],
                            ),
                          ),


                        ],
                      )),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Enter pin again!',
            style: TextStyle(fontSize: 25,
                color: ColorConstants.secondaryColor
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              ' Please remember this pin. It will be used to keep your account secured.',
              style:
              TextStyle(fontSize: 18, color: ColorConstants.whiteLighterColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  void _setPin(String lockCode) async {
    //kopenPage(context, LandingPage());
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map['lock_code'] = lockCode;



      var response = await http
          .post(HttpService.rootUserPin, body: map,headers: {
        'Authorization': 'Bearer '+HttpService.token,
      })
          .timeout(const Duration(seconds: 15), onTimeout: () {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'The connection has timed out, please try again!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        EmailVerificationData regUser = EmailVerificationData.fromJson(body);

        bool status = regUser.status;
        String message = regUser.message;
        if (status) {
          cPageState(state: false);

          String id = regUser.data.id.toString();
          String userId = regUser.data.userId.toString();
          String firstName = regUser.data.firstName.toString();
          String surName = regUser.data.surname.toString();
          String emailAddress = regUser.data.emailAddress.toString();
          String nairaBalance = regUser.data.nairaBalance.toString();



          String verifiedEmail = regUser.data.verifiedEmail.toString();

          //saving user data to sharedprefs
          SharedPrefrences.addStringToSP("userId", userId);
          SharedPrefrences.addStringToSP("email_address", emailAddress);
          SharedPrefrences.addStringToSP("nairaBalance", nairaBalance);
          SharedPrefrences.addStringToSP("first_name", firstName);
          SharedPrefrences.addStringToSP("surname", surName);
          SharedPrefrences.addStringToSP("verified_email", verifiedEmail);


          SharedPrefrences.addStringToSP("lock_code", widget.textPin);

          ShowSnackBar.showInSnackBar(
              iconData: Icons.check_circle,
              bgColor: ColorConstants.secondaryColor,
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
              bgColor: ColorConstants.secondaryColor,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      cPageState(state: false);
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void _redirectuser() {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 3), () {
      pushPage(context, LandingPage());
    });
  }
}

class PinScreen extends StatefulWidget {
  final String textPin;
  final GlobalKey<ScaffoldState> scaffold;

  const PinScreen({Key key, this.textPin, this.scaffold}) : super(key: key);
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String confirmText;

  @override
  void initState() {
    super.initState();

    confirmText = '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: Column(children: <Widget>[
            SizedBox(
              height: Dims.sizedBoxHeight(height: 50),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: Dims.sizedBoxHeight(
                          height: Dims.screenHeight(context) * 0.12),
                    ),
                    GestureDetector(onTap: () {}, child: _buildSecurityText()),
                    SizedBox(
                      height: Dims.sizedBoxHeight(
                          height: Dims.screenHeight(context) * 0.10),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: PinEntryTextField(
                        showFieldAsBox: false,
                        isTextObscure: true,
                        fieldWidth: 30.0,
                        fontSize: 30.0,
                        fields: 4,
                        onSubmit: (text) {
                          confirmText = text as String;

                          if (widget.textPin == confirmText) {
                            ShowSnackBar.showInSnackBar(
                                bgColor: ColorConstants.secondaryColor,
                                iconData: Icons.check_circle,
                                value: 'Pin set successfully',
                                context: context,
                                scaffoldKey: widget.scaffold,
                                timer: 5);
                            SharedPrefrences.addStringToSP(
                                "lock_code", widget.textPin);
                            Future.delayed(Duration(seconds: 5), () {
                              kopenPage(context, LandingPage());
                            });
                          } else {
                            ShowSnackBar.showInSnackBar(
                                bgColor: ColorConstants.secondaryColor,
                                value: 'Pin does not match',
                                context: context,
                                scaffoldKey: widget.scaffold,
                                timer: 5);

                            Future.delayed(Duration(seconds: 5), () {
                              kbackBtn(context);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  Widget _buildSecurityText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Enter pin again!',
            style: TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ' Please remember this pin. It will be used to keep your account secured.',
            style: TextStyle(fontSize: 25, color: ColorConstants.primaryColor),
          ),
        ),
      ],
    );
  }
}
