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
import 'package:mabro/constants/string_constants/string_constants.dart';
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
  String _email, _password, _confirmPassword;
  int charLength;
  bool pageState, checkState;

  bool isUserActive = false;
  bool isFirstScreen;

  checkFirstScreen() {
    if (widget.userPin != '') {
      isFirstScreen = true;
    } else {
      isFirstScreen = false;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeConfirmPassword = FocusNode();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
    _confirmPassword = '';
    charLength = 0;
    pageState = false;
    checkState = false;
    isFirstScreen = false;
    checkFirstScreen();
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeConfirmPassword.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: (isFirstScreen)
          ? MainScreenLock()
          : (pageState)
              ? loadingPage(state: pageState)
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: Dims.screenHeight(context) * 0.05,
                      ),
                      CircleAvatar(
                        maxRadius: 45,
                        backgroundColor: ColorConstants.lightSecondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              kopenPage(context, LandingPage());
                            },
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
                      Text(
                        'Sign Up'.toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(
                            height: Dims.screenHeight(context) * 0.04),
                      ),
                      _buildSignUpForm(context),
                      Padding(
                        padding: Dims.horizontalPadding(value: 8),
                        child: Text(
                          Constants.PASSWORD_DETAILS,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(
                            height: Dims.screenHeight(context) * 0.04),
                      ),
                      Container(
                        color: ColorConstants.grey.withOpacity(0.4),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
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
                                          kopenPage(
                                              context, PrivacyPolicyPage());
                                        },
                                        text1: 'By signing up, I agree to the ',
                                        text2: ' terms of use',
                                        text3:
                                            'and processsing of my personal data as stated in the ',
                                        text4: 'privacy policy'),
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
                                        textSize: 16),
                                    SizedBox(width: 10),
                                    TextStyles.textDetails(
                                        textValue: 'Sign In'.toUpperCase(),
                                        textSize: 16,
                                        textColor: Colors.red),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Form(
      child: Column(children: [
        RoundedTextfield(
          icon: Icons.email_outlined,
          hintText: 'Email',
          labelText: 'Email',
          controller: signupEmailController,
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
          height: 30,
        ),
        PasswordTextField(
          icon: Icons.lock,
          textHint: 'Confirm Password',
          controller: signupConfirmPasswordController,
          myFocusNode: myFocusNodeConfirmPassword,
          labelText: '',
          onChanged: (cpassword) {
            _confirmPassword = cpassword;
          },
        ),
        SizedBox(
          height: Dims.sizedBoxHeight(),
        ),
      ]),
    );
  }

  void _signUp() async {
    if (signupEmailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'email field required',
          bgColor: ColorConstants.primaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signupPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'password field required',
          bgColor: ColorConstants.primaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signupConfirmPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'confirm password field required',
          bgColor: ColorConstants.primaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (signupPasswordController.text !=
        signupConfirmPasswordController.text) {
      ShowSnackBar.showInSnackBar(
          value: 'password does not match',
          bgColor: ColorConstants.primaryColor,
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (charLength < 8) {
      ShowSnackBar.showInSnackBar(
          value: 'password must not be less than 8 characters',
          bgColor: ColorConstants.primaryColor,
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
            .post(HttpService.rootReg, body: map)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'The connection has timed out, please try again!',
              bgColor: ColorConstants.primaryColor,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          RegisterUser regUser = RegisterUser.fromJson(body);

          bool status = regUser.status;
          String message = regUser.message;
          if (status) {
            cPageState(state: false);
            String code = regUser.data.code;
            String id = regUser.data.id.toString();
            String email = regUser.data.emailAddress;

            SharedPrefrences.addStringToSP("id", id);
            SharedPrefrences.addBoolToSP("showBalance", false);

            SharedPrefrences.addStringToSP("lock_code", '');
            SharedPrefrences.addStringToSP("phone_number", '');
            SharedPrefrences.addStringToSP("account_number", '');
            SharedPrefrences.addStringToSP("password", _password);
            SharedPrefrences.addStringToSP(
                "email_address", signupEmailController.text);

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);

            _redirectuser(code);
          } else if (!status) {
            cPageState(state: false);
            ShowSnackBar.showInSnackBar(
                value: message,
                bgColor: ColorConstants.primaryColor,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
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

  void _redirectuser(String code) {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 3), () {
      pushPage(
          context,
          SentEmailPage(
            emailAddress: signupEmailController.text,
            code: code,
          ));
      signupEmailController.text = '';
      signupPasswordController.text = '';
      signupConfirmPasswordController.text = '';
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
