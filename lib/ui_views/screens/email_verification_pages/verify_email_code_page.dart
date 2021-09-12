import 'package:flutter/gestures.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/screens/password_setting/set_password_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/email_verification_data.dart.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';

import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class EmailVerificationPage extends StatefulWidget {
  final String emailAddress;

  EmailVerificationPage({Key key, this.emailAddress}) : super(key: key);
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  String code, email, message;
  bool pageState;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String smsOTP = '';
  int pinIndex = 0;
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();


  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pageState = false;
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: ColorConstants.primaryColor,
          key: _scaffoldKey,
          body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dims.sizedBoxHeight(height: 60),
                    ),
                    Center(
                      child: Container(
                        child: Image(
                          image: AssetImage('assets/images/email2.png'),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dims.sizedBoxHeight(height: 2.0),
                    ),
                    TextStyles.textHeadings(
                      textValue: 'Check Your email',
                      textColor: ColorConstants.whiteLighterColor
                    ),
                    SizedBox(
                      height: Dims.sizedBoxHeight(height: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Enter the 6-digit code we sent to',
                          style: TextStyle(fontSize: 16,
                              color: ColorConstants.whiteLighterColor
                          ),
                        ),
                        Text(
                          widget.emailAddress,
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.secondaryColor),
                        ),
                        Text(
                          'to continue',
                          style: TextStyle(fontSize: 16,
                              color: ColorConstants.whiteLighterColor
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dims.sizedBoxHeight(),
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
                                    shape: PinCodeFieldShape.box,
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    activeFillColor:
                                    hasError ? Colors.orange : Colors.white,
                                  ),
                                  cursorColor: Colors.white,
                                  animationDuration: Duration(milliseconds: 300),
                                  textStyle: TextStyle(fontSize: 26, height: 1.6, color: ColorConstants.white),
                                  backgroundColor: ColorConstants.primaryColor,
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
                                    // conditions for validating
                                    if (currentText.length != 6) {

                                    } else {
                                      setState(() {
                                        hasError = false;
                                        textEditingController.text = '';
                                        sendOtp(v, widget.emailAddress);
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
                          TextStyles.textHeadings(
                              textValue: 'RESEND VIA EMAIL',
                              textSize: 14.0,
                              textColor: ColorConstants.whiteLighterColor
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
        ),
      ],
    );
  }

  void sendOtp(String code, String email) async {
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['email_address'] = email;
      map['code'] = code;

      var response = await http
          .post(HttpService.rootVerifyEmail, body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'The connection has timed out, please try again!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);

        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        EmailVerificationData verifyUser = EmailVerificationData.fromJson(body);

        bool status = verifyUser.status;
        String message = verifyUser.message;
        if (status) {
          cPageState(state: false);

          //user data info
          String id = verifyUser.data.id.toString();
          //String user = verifyUser.data.user.toString();
          String emailAddress = verifyUser.data.emailAddress.toString();
          String nairaBalance = verifyUser.data.nariaBalance.toString();
          String bitcoinBalance = verifyUser.data.bitcoinBalance.toString();
          String bitcoinAddress = verifyUser.data.bitcoinAddress.toString();
          String verifiedEmail = verifyUser.data.verifiedEmail.toString();

          //saving user data to sharedprefs
          SharedPrefrences.addStringToSP("id", id);
          SharedPrefrences.addStringToSP("email_address", emailAddress);
          SharedPrefrences.addStringToSP("naria_balance", nairaBalance);
          SharedPrefrences.addStringToSP("bitcoin_balance", bitcoinBalance);
          SharedPrefrences.addStringToSP("bitcoin_address", bitcoinAddress);
          SharedPrefrences.addStringToSP("verified_email", verifiedEmail);

          //user user settings info
          String user = verifyUser.data.settings.user.toString();
          String defaultAccount =
              verifyUser.data.settings.defaultAccount.toString();
          String addFundPhoneAlert =
              verifyUser.data.settings.addFundPhoneAlert.toString();
          String withdrawFundPhoneAlert =
              verifyUser.data.settings.withdrawFundPhoneAlert.toString();
          String addFundEmailAlert =
              verifyUser.data.settings.addFundEmailAlert.toString();
          String withdrawFundEmailAlert =
              verifyUser.data.settings.withdrawFundEmailAlert.toString();
          String buyAssetPhoneAlert =
              verifyUser.data.settings.buyAssetPhoneAlert.toString();
          String buyAssetEmailAlert =
              verifyUser.data.settings.buyAssetEmailAlert.toString();
          String sellAssetPhoneAlert =
              verifyUser.data.settings.sellAssetPhoneAlert.toString();
          String sellAssetEmailAlert =
              verifyUser.data.settings.sellAssetEmailAlert.toString();
          String loginEmailAlert =
              verifyUser.data.settings.loginEmailAlert.toString();
          String newsletterPhoneAlert =
              verifyUser.data.settings.newsletterPhoneAlert.toString();
          String newsletterEmailAlert =
              verifyUser.data.settings.newsletterEmailAlert.toString();
          String smsAlert = verifyUser.data.settings.smsAlert.toString();
          String twoFactorAuth =
              verifyUser.data.settings.twoFactorAuth.toString();

          //saving user data to sharedprefs
          SharedPrefrences.addStringToSP("user", user);
          SharedPrefrences.addStringToSP("default_account", defaultAccount);
          SharedPrefrences.addStringToSP(
              "add_fund_phone_alert", addFundPhoneAlert);
          SharedPrefrences.addStringToSP(
              "withdraw_fund_phone_alert", withdrawFundPhoneAlert);
          SharedPrefrences.addStringToSP(
              "add_fund_email_alert", addFundEmailAlert);
          SharedPrefrences.addStringToSP(
              "withdraw_fund_email_alert", withdrawFundEmailAlert);
          SharedPrefrences.addStringToSP(
              "buy_asset_phone_alert", buyAssetPhoneAlert);
          SharedPrefrences.addStringToSP(
              "sell_asset_phone_alert", sellAssetPhoneAlert);
          SharedPrefrences.addStringToSP(
              "buy_asset_email_alert", buyAssetEmailAlert);
          SharedPrefrences.addStringToSP(
              "sell_asset_email_alert", sellAssetEmailAlert);
          SharedPrefrences.addStringToSP("login_email_alert", loginEmailAlert);
          SharedPrefrences.addStringToSP(
              "newsletter_phone_alert", newsletterPhoneAlert);
          SharedPrefrences.addStringToSP(
              "newsletter_email_alert", newsletterEmailAlert);
          SharedPrefrences.addStringToSP("sms_alert", smsAlert);
          SharedPrefrences.addStringToSP("two_factor_auth", twoFactorAuth);

          ShowSnackBar.showInSnackBar(
              value: message,
              iconData: Icons.check_circle,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5,
              bgColor: ColorConstants.secondaryColor);

          _redirectuser();
        } else if (!status) {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.secondaryColor,
              value: message,
              context: context,
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

  void _redirectuser() {
    pushPage(context, SetPinPage());
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
