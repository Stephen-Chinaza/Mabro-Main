import 'dart:async';
import 'dart:io';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/screens/email_verification_pages/sent_email_page.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/main_lock_screen.dart';
import 'package:mabro/ui_views/screens/user_agreement_page/terms_of_use_page.dart';
import 'package:mabro/ui_views/screens/user_agreement_page/privacy_policy_page.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_in_page.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final String userPin;

  const SignUpPage({Key key, this.userPin = ''}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password, _name;
  int charLength;
  bool pageState, checkState;

  bool isUserActive = false;
  bool isFirstScreen;

  checkFirstScreen() {
    if (widget.userPin == '') {
      isFirstScreen = false;
    } else {
      isFirstScreen = true;
    }
    print(isFirstScreen);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
    _name = '';
    charLength = 0;
    pageState = false;
    checkState = false;

    checkFirstScreen();
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      body: (isFirstScreen)
          ? MainScreenLock(
              userPin: widget.userPin,
            )
          : (pageState)
              ? loadingPage(state: pageState)
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(children: <Widget>[
                      SafeArea(child: SizedBox(height: 5)),
                      _buildSignUpForm(context),
                      SizedBox(
                        height: 1,
                      ),
                    ]),
                  ),
                ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 70, top: 15),
          child: Form(
            child: Column(children: [
              Image.asset('assets/images/mabrologo.png'),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  kopenPage(context, LandingPage());
                },
                child: Text(
                  'Create A new account'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.secondaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RoundedTextfield(
                icon: Icons.person,
                hintText: 'Full name',
                labelText: 'Full name',
                controller: signupNameController,
                myFocusNode: myFocusNodeName,
                textInputType: TextInputType.name,
                onChanged: (name) {
                  _name = name;
                },
              ),
              SizedBox(
                height: 15,
              ),
              RoundedTextfield(
                icon: Icons.email_outlined,
                hintText: 'Email address',
                labelText: 'Email address',
                controller: signupEmailController,
                myFocusNode: myFocusNodeEmail,
                textInputType: TextInputType.emailAddress,
                onChanged: (email) {
                  _email = email;
                },
              ),
              SizedBox(
                height: 15,
              ),
              PasswordTextField(
                icon: Icons.lock,
                textHint: 'Password',
                controller: signupPasswordController,
                myFocusNode: myFocusNodePassword,
                labelText: '',
                onChanged: (password) {
                  setState(() {
                    _password = password;
                    charLength = password.length;
                  });
                },
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                            activeColor: ColorConstants.secondaryColor,
                            checkColor: ColorConstants.whiteLighterColor,
                            side: BorderSide(
                                color: ColorConstants.whiteLighterColor),
                            value: checkState,
                            onChanged: (state) {
                              setState(() {
                                checkState = state;
                              });
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextStyles.richTexts(
                            onPress1: () {
                              kopenPage(context, TermsOfUsePage());
                            },
                            onPress2: () {
                              kopenPage(context, PrivacyPolicyPage());
                            },
                            text1: 'By signing up, I agree to the ',
                            text2: ' terms of use',
                            text3: '',
                            text4: ''),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dims.sizedBoxHeight(
                        height: Dims.screenHeight(context) * 0.03),
                  ),
                  CustomButton(
                      margin: 0,
                      disableButton: checkState,
                      onPressed: () {
                        _signUp();
                      },
                      text: 'Sign Up'),
                  SizedBox(
                    height: Dims.sizedBoxHeight(height: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      kopenPage(context, SignInPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextStyles.textDetails(
                            textValue: 'Already have an account?',
                            textSize: 14),
                        SizedBox(width: 10),
                        TextStyles.textDetails(
                            textValue: 'Sign In'.toUpperCase(),
                            textSize: 14,
                            textColor: ColorConstants.secondaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (signupNameController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'name field required',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signupEmailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'email field required',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signupPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'password field required',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (charLength < 8) {
      ShowSnackBar.showInSnackBar(
          value: 'password must not be less than 8 characters',
          bgColor: ColorConstants.secondaryColor,
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      cPageState(state: true);
      String message;
      String cause;
      String userId;
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = _email;
        map['password'] = _password;
        map['name'] = _name;

        var response =
            await http.post(HttpService.rootReg, body: map, headers: {
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
            String otp = regUser.data.oTP;
            userId = regUser.data.userId;
            message = regUser.message;

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            SharedPrefrences.addStringToSP("userId", userId);
            SharedPrefrences.addStringToSP("password", _password);

            _redirectuser(code: otp, userId: userId);
          } else if (!status) {
            cPageState(state: false);
            cause = regUser.causes.emailAddress;

            ShowSnackBar.showInSnackBar(
                value: cause,
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

  void _redirectuser({String code, String userId}) {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 3), () {
      pushPage(
          context,
          SentEmailPage(
            emailAddress: signupEmailController.text,
            userId: userId,
            code: code,
          ));
      signupEmailController.text = '';
      signupPasswordController.text = '';
      signupNameController.text = '';
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
