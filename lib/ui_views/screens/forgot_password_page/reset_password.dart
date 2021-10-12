import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_in_page.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordPage extends StatefulWidget {
  final String userEmail;
  final String otp;
  final String userId;

  const ResetPasswordPage({Key key, this.userEmail, this.otp, this.userId})
      : super(key: key);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool pageState;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeCPassword = FocusNode();
  final FocusNode myFocusNodeToken = FocusNode();

  TextEditingController signinEmailController = new TextEditingController();
  TextEditingController signinPasswordController = new TextEditingController();
  TextEditingController signinCPasswordController = new TextEditingController();
  TextEditingController tokenController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    signinEmailController.text = widget.userEmail;

    pageState = false;
  }

  @override
  void dispose() {
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    myFocusNodeCPassword.dispose();
    myFocusNodeToken.dispose();
    signinEmailController.dispose();
    signinPasswordController.dispose();
    signinCPasswordController.dispose();
    tokenController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: (pageState)
          ? loadingPage(state: pageState)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: SizedBox(
                        height: 5,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Card(
                        color: ColorConstants.primaryLighterColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dims.sizedBoxHeight(height: 10),
                              ),
                              TextStyles.textDetails(
                                  textValue: 'Reset Password '.toUpperCase(),
                                  textSize: 16,
                                  textColor: ColorConstants.secondaryColor),
                              SizedBox(
                                height: Dims.sizedBoxHeight(height: 20),
                              ),
                              Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 0.5),
                              SizedBox(
                                height: Dims.sizedBoxHeight(height: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextStyles.textDetails(
                                  textValue:
                                      'A token has been sent to your email please provide the following details to reset your password.',
                                  textSize: 16,
                                  textColor: ColorConstants.whiteLighterColor,
                                ),
                              ),
                              SizedBox(height: 20),
                              RoundedTextfield(
                                icon: Icons.email_outlined,
                                hintText: 'Please Enter Email',
                                labelText: 'Email',
                                isEditable: false,
                                controller: signinEmailController,
                                myFocusNode: myFocusNodeEmail,
                                textInputType: TextInputType.emailAddress,
                                onChanged: (email) {},
                              ),
                              SizedBox(
                                height: Dims.sizedBoxHeight(),
                              ),
                              PasswordTextField(
                                icon: Icons.lock_open,
                                textHint: 'Password',
                                controller: signinPasswordController,
                                labelText: '',
                                onChanged: (password) {},
                              ),
                              SizedBox(
                                height: Dims.sizedBoxHeight(),
                              ),
                              PasswordTextField(
                                icon: Icons.lock_open,
                                textHint: 'Password Again',
                                controller: signinCPasswordController,
                                labelText: '',
                                onChanged: (password) {},
                              ),
                              SizedBox(
                                height: Dims.sizedBoxHeight(),
                              ),
                              RoundedTextfield(
                                icon: Icons.vpn_key,
                                hintText: 'Enter Token',
                                labelText: 'Token',
                                controller: tokenController,
                                textInputType: TextInputType.name,
                                onChanged: (token) {},
                              ),
                              SizedBox(
                                height: Dims.sizedBoxHeight(height: 30),
                              ),
                              CustomButton(
                                  margin: 0,
                                  disableButton: true,
                                  onPressed: () {
                                    _sendOtp();
                                  },
                                  text: 'Reset Password'),
                            ],
                          ),
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
    } else if (tokenController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'enter sent token',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signinPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'password field required',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signinCPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 're-enter password',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signinPasswordController.text.isEmpty !=
        signinCPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'password fields does not match',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else {
      cPageState(state: true);
      String message;
      String userId;
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = signinEmailController.text;
        map['otp'] = tokenController.text;

        var response =
            await http.post(HttpService.rootResendEmail, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
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

          RegisterUser data = RegisterUser.fromJson(body);

          bool status = data.status;
          message = data.message;
          if (status) {
            cPageState(state: false);
            String otp = data.data.oTP;
            userId = data.data.userId;

            // ShowSnackBar.showInSnackBar(
            //     iconData: Icons.check_circle,
            //     value: message,
            //     context: context,
            //     scaffoldKey: _scaffoldKey,
            //     timer: 5);

            print(userId);
            _resetPassword();
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
  }

  void _resetPassword() async {
    cPageState(state: true);
    String message;
    String userId;
    try {
      var map = Map<String, dynamic>();
      map['userId'] = widget.userId;
      map['password'] = signinPasswordController.text;
      map['repeat_password'] = signinCPasswordController.text;

      var response =
          await http.post(HttpService.rootResetPassword, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
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
          // String otp = regUser.data.oTP;
          //userId = regUser.data.userId;
          message = regUser.message;

          ShowSnackBar.showInSnackBar(
              iconData: Icons.check_circle,
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

  void _redirectuser({String code, String userId}) {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 3), () {
      pushPage(context, SignInPage());
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
