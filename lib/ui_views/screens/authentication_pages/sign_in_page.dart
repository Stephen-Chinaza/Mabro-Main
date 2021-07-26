import 'package:mabro/core/models/login_user.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_up_page.dart';
import 'package:mabro/ui_views/screens/forgot_password_page/forgot_password_page.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/screens/password_setting/set_password_page.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/services/repositories.dart';

import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email, _password;
  String message, vEmail, id;
  bool pageState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();

  TextEditingController signinEmailController = new TextEditingController();
  TextEditingController signinPasswordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    pageState = false;
    _email = '';
    _password = '';
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    signinEmailController.dispose();
    signinPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: (pageState)
          ? loadingPage(state: pageState)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: Dims.screenHeight(context) * 0.05,
                      ),
                      Center(
                        child: CircleAvatar(
                          maxRadius: 45,
                          backgroundColor: ColorConstants.lightSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage('assets/images/mabrologo.jpg'),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(
                            height: Dims.screenHeight(context) * 0.014),
                      ),
                      Center(
                        child: Text(
                          'Sign In'.toUpperCase(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 40),
                      ),
                      _buildSignUpForm(context),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          kopenPage(context, ForgotPasswordPage());
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextStyles.textDetails(
                              textValue: 'Forgot Password?'.toUpperCase(),
                              textSize: 14,
                              textColor: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 30),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Dims.sizedBoxHeight(height: 20),
                            ),
                            CustomButton(
                                margin: 0,
                                disableButton: true,
                                onPressed: () {
                                  _signIn();
                                },
                                text: 'Sign In'),
                            SizedBox(
                              height: Dims.sizedBoxHeight(height: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                kopenPage(context, SignUpPage());
                              },
                              child: Row(
                                children: [
                                  TextStyles.textDetails(
                                      textValue: 'Dont have an account?',
                                      textSize: 16),
                                  SizedBox(width: 10),
                                  TextStyles.textDetails(
                                      textValue: 'Sign Up'.toUpperCase(),
                                      textSize: 16,
                                      textColor: Colors.red),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Form(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 30,
        ),
        RoundedTextfield(
          icon: Icons.email_outlined,
          hintText: 'Enter Email',
          labelText: '',
          controller: signinEmailController,
          myFocusNode: myFocusNodeEmail,
          textInputType: TextInputType.emailAddress,
          onChanged: (email) {
            _email = email;
          },
        ),
        SizedBox(
          height: 30,
        ),
        PasswordTextField(
          icon: Icons.lock_open,
          textHint: 'Password',
          controller: signinPasswordController,
          myFocusNode: myFocusNodePassword,
          labelText: '',
          onChanged: (password) {
            _password = password;
          },
        ),
      ]),
    );
  }

  void _signIn() async {
    if (signinEmailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'email field required',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (signinPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'password field required',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = _email;
        map['password'] = _password;

        var response = await http
            .post(HttpService.rootLogin, body: map)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
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
            cPageState(state: false);
            String verifiedEmail = loginUser.data.verifiedEmail.toString();
            String blocked = loginUser.data.blocked.toString();
            String lockCode = loginUser.data.lockCode;

            //TODO CHECK IF USER IS BLOCKED OR LOCK_CODE IS SET
            if (verifiedEmail == '1') {
              if (lockCode == '') {
                ShowSnackBar.showInSnackBar(
                    bgColor: ColorConstants.primaryColor,
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
                      bgColor: ColorConstants.primaryColor,
                      value: 'User is currently blocked',
                      context: context,
                      scaffoldKey: _scaffoldKey,
                      timer: 5);
                } else {
                  String firstName = loginUser.data.firstName;
                  //String surName = loginUser.data.surName;
                  String phone = loginUser.data.phoneNumber;
                  String id = loginUser.data.id.toString();
                  String email = loginUser.data.emailAddress;
                  String lockCode = loginUser.data.lockCode;
                  String nairaBalance = loginUser.data.nariaBalance;
                  String bitcoinBalance = loginUser.data.bitcoinBalance;
                  String bitcoinAddress = loginUser.data.bitcoinAddress;

                  SharedPrefrences.addStringToSP("lock_code", lockCode);
                  SharedPrefrences.addStringToSP(
                      "bitcoin_balance", bitcoinBalance);
                  SharedPrefrences.addStringToSP(
                      "bitcoin_address", bitcoinAddress);
                  SharedPrefrences.addStringToSP("naria_balance", nairaBalance);

                  SharedPrefrences.addStringToSP("first_name", firstName);
                  SharedPrefrences.addStringToSP("phone_number", phone);
                  SharedPrefrences.addStringToSP("id", id);
                  SharedPrefrences.addStringToSP("email_address", email);
                  SharedPrefrences.addStringToSP("blocked", blocked);

                  ShowSnackBar.showInSnackBar(
                    value: message,
                    iconData: Icons.check_circle,
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    timer: 5,
                  );

                  _redirectuser();
                  signinEmailController.text = '';
                  signinPasswordController.text = '';
                }
              }
            } else {
              ShowSnackBar.showInSnackBar(
                  bgColor: ColorConstants.primaryColor,
                  value: 'Please verify your email',
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  timer: 5);
            }
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.primaryColor,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            cPageState(state: false);
          }
        } else {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void _redirectuser() {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 2), () {
      pushPage(context, LandingPage());
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
