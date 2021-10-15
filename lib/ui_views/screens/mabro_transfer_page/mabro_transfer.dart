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
import 'package:shared_preferences/shared_preferences.dart';

class MabroTransferPage extends StatefulWidget {
  @override
  _MabroTransferPageState createState() => _MabroTransferPageState();
}

class _MabroTransferPageState extends State<MabroTransferPage> {
  String message, vEmail, userId;
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeAmount = FocusNode();
  bool pageState;
  TextEditingController emailController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();

  Future<void> getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');

    setState(() {});
  }

  String _email, _amount;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    myFocusNodeAmount.dispose();
    myFocusNodeEmail.dispose();
    emailController.dispose();
    amountController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageState = false;
    _email = '';
    _amount = '';

    getUserDetails().then((value) => {
          setState(() {}),
        });
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
          child: Form(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  'Mabro Transfer'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.secondaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RoundedTextfield(
                icon: Icons.email_outlined,
                hintText: 'Enter your email address',
                labelText: '',
                controller: emailController,
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
                icon: Icons.lock_open,
                textHint: 'Enter amount',
                controller: amountController,
                myFocusNode: myFocusNodeAmount,
                labelText: '',
                onChanged: (amount) {
                  _amount = amount;
                },
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(height: 15),
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
                      textColor: ColorConstants.whiteLighterColor),
                ),
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(height: 10),
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
                          _verifyUser();
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
                              textValue: "Don't have an account?",
                              textSize: 14),
                          SizedBox(width: 10),
                          TextStyles.textDetails(
                              textValue: 'Sign Up'.toUpperCase(),
                              textSize: 14,
                              textColor: ColorConstants.secondaryColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _verifyUser() async {
    if (emailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'email field required',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'password field required',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = emailController.text;
        map['userId'] = amountController;

        var response =
            await http.post(HttpService.rootLogin, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
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
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.secondaryColor,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            cPageState(state: false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      body: (pageState)
          ? loadingPage(state: pageState)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(children: <Widget>[
                  SafeArea(child: SizedBox(height: 5)),
                  _buildSignUpForm(context),
                ]),
              ),
            ),
    );
  }
}
