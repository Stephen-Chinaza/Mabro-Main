import 'dart:convert';
import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
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
  String user;

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    user = (pref.getString('user') ?? '');
  }

  @override
  void initState() {
    super.initState();

    pageState = false;
    checkState = false;

    confirmText = '';
    checkFirstScreen();
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
          backgroundColor: Colors.white,
          body: (pageState)
              ? loadingPage(state: pageState)
              : SingleChildScrollView(
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
                                      height:
                                          Dims.screenHeight(context) * 0.12),
                                ),
                                GestureDetector(
                                    onTap: () {}, child: _buildSecurityText()),
                                SizedBox(
                                  height: Dims.sizedBoxHeight(
                                      height:
                                          Dims.screenHeight(context) * 0.10),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: PinEntryTextField(
                                    showFieldAsBox: false,
                                    isTextObscure: true,
                                    fieldWidth: 30.0,
                                    fontSize: 30.0,
                                    fields: 4,
                                    onSubmit: (text) {
                                      confirmText = text as String;

                                      if (widget.textPin == confirmText) {
                                        _setPin(widget.textPin);
                                      } else {
                                        ShowSnackBar.showInSnackBar(
                                            bgColor:
                                                ColorConstants.primaryColor,
                                            value: 'Pin does not match',
                                            context: context,
                                            scaffoldKey: _scaffoldKey,
                                            timer: 5);

                                        Future.delayed(Duration(seconds: 5),
                                            () {
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
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              ' Please remember this pin. It will be used to keep your account secured.',
              style:
                  TextStyle(fontSize: 22, color: ColorConstants.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  void _setPin(String code) async {
    //kopenPage(context, LandingPage());
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['user'] = user;
      map['lock_code'] = code;

      var response = await http
          .post(HttpService.rootUserPin, body: map)
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

        RegisterUser regUser = RegisterUser.fromJson(body);

        bool status = regUser.status;
        String message = regUser.message;
        if (status) {
          cPageState(state: false);

          SharedPrefrences.addStringToSP("lock_code", widget.textPin);

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
                                bgColor: Colors.green,
                                iconData: Icons.check_circle,
                                value: 'Pin set sucessfully',
                                context: context,
                                scaffoldKey: widget.scaffold,
                                timer: 5);
                            SharedPrefrences.addStringToSP(
                                "lock_code", widget.textPin);
                            // Future.delayed(Duration(seconds: 5), () {
                            //   kopenPage(context, LandingPage());
                            // });
                          } else {
                            ShowSnackBar.showInSnackBar(
                                bgColor: ColorConstants.primaryColor,
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
