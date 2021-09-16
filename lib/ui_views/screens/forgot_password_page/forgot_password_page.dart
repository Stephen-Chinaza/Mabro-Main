import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/screens/forgot_password_page/reset_password.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FocusNode myFocusNodeEmail = FocusNode();

  bool pageState;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController signinEmailController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    pageState = false;
  }

  @override
  void dispose() {
    myFocusNodeEmail.dispose();
    signinEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      body: (pageState)
          ? loadingPage(state: pageState)
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(child: SizedBox(height: 5)),
              Container(
                height: 370,
                child: Card(
                  color: ColorConstants.primaryLighterColor,
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      TextStyles.textHeadings(
                          textValue: 'Reset Password'.toUpperCase(),
                          textSize: 16,
                          textColor: ColorConstants.whiteColor),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 20),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2), height: 0.5),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 20),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: TextStyles.textDetails(
                            textValue:
                            'Please provide the following details to reset your password.',
                            textSize: 16,
                            textColor: ColorConstants.whiteLighterColor),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedTextfield(
                          icon: Icons.email_outlined,
                          hintText: 'Please Enter Email',
                          labelText: 'Email',
                          controller: signinEmailController,
                          myFocusNode: myFocusNodeEmail,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (email) {},
                        ),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                            margin: 0,
                            disableButton: true,
                            onPressed: () {
                              //_redirectuser(code: '909099', userId: 'tguy566g', userEmail: signinEmailController.text);
                              _sendOtp();
                            },
                            text: 'Reset Password'),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _sendOtp() async {
    if (signinEmailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'email field required',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    }  else {
      cPageState(state: true);
      String message;
      String cause;
      String userId;
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = signinEmailController.text;


        var response = await http
            .post(HttpService.rootForgotPassword, body: map, headers: {
          'Authorization': 'Bearer '+HttpService.token,
        })
            .timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
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

          RegisterUser regUser = RegisterUser.fromJson(body);

          bool status = regUser.status;


          if (status) {
            cPageState(state: false);
            String otp = regUser.data.oTP;
            userId = regUser.data.userId;
            message = regUser.message;

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);

            _redirectuser(code: otp, userId: userId);
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
      }
      on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void _redirectuser({String code, String userId, String userEmail}) {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 3), () {

          kopenPage(
          context,
          ResetPasswordPage(
            userId: userId,
          userEmail: signinEmailController.text,
          otp: code,
      ));
      signinEmailController.text = '';

    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
