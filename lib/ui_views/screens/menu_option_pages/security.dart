import 'dart:convert';
import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/models/update_password.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:typicons_flutter/typicons_flutter.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  int pinLength = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.white,
          appBar: TopBar(
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
            title: 'Security',
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: MenuInfo(),
        ),
      ],
    );
  }
}

class MenuInfo extends StatefulWidget {
  @override
  _MenuInfoState createState() => _MenuInfoState();
}

class _MenuInfoState extends State<MenuInfo> {
  String twoFactorAuth, fingerPrintLogin, timeoutLock;
  bool twoFactorState, fingerPrintState, timeoutLockState;
  String userId;
  bool updateState;
  String password;

  TextEditingController oldPinController = new TextEditingController();
  TextEditingController newPinController = new TextEditingController();
  TextEditingController cNewPinController = new TextEditingController();

  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController cNewPasswordController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    updateState = false;
    getData().then((value) => {});
    twoFactorState = false;
    fingerPrintState = true;
    timeoutLockState = false;
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    password = (pref.getString('password') ?? '');
    userId = (pref.getString('userId') ?? '');
    twoFactorAuth = (pref.getString('two_factor_authentication') ?? ''); //
    fingerPrintLogin = (pref.getString('finger_print_login') ?? ''); //
    timeoutLock = (pref.getString('timeout_lock') ?? '');

    updateSecurityState();

    setState(() {});
  }

  void updateSecurityState() {
    if (twoFactorAuth == '1') {
      twoFactorState = true;
    } else {
      twoFactorState = false;
    }

    if (fingerPrintLogin == '1') {
      fingerPrintState = true;
    } else {
      fingerPrintState = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      body: Container(
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: updateState,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'updating...',
                      style: TextStyle(
                          fontSize: 16, color: ColorConstants.secondaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Card(
                elevation: 3,
                color: ColorConstants.primaryLighterColor,
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 1, left: 1, right: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ...ListTile.divideTiles(
                            color: Colors.grey,
                            tiles: [
                              buildListTile(
                                  title: "Reset Pin",
                                  icon: Typicons.lock_open,
                                  widget: null,
                                  onTapped: () {
                                    buildShowBottomSheet(
                                      context: context,
                                      bottomsheetContent:
                                          _bottomSheetPinContent(context),
                                    );
                                  }),
                              buildListTile(
                                  title: "Reset Password",
                                  icon: Typicons.lock_open,
                                  widget: null,
                                  onTapped: () {
                                    buildShowBottomSheet(
                                      context: context,
                                      bottomsheetContent:
                                          _bottomSheetPasswordContent(context),
                                    );
                                  }),
                              buildListTile(
                                  title: "2 - Factor Authentication",
                                  icon: Icons.security,
                                  widget: Switch(
                                    activeColor: ColorConstants.secondaryColor,
                                    activeTrackColor: ColorConstants.whiteColor,
                                    inactiveTrackColor: ColorConstants
                                        .whiteLighterColor
                                        .withOpacity(0.4),
                                    inactiveThumbColor:
                                        ColorConstants.whiteLighterColor,
                                    value: twoFactorState,
                                    onChanged: (bool value) {
                                      setState(() {
                                        twoFactorState = value;
                                        if (twoFactorState) {
                                          updateSettings(
                                              key: 'two_factor_authentication',
                                              value: '1');
                                        } else {
                                          updateSettings(
                                              key: 'two_factor_authentication',
                                              value: '0');
                                        }
                                      });
                                    },
                                  ),
                                  onTapped: () {}),
                              buildListTile(
                                  title: "Setup Touch ID",
                                  icon: Icons.touch_app,
                                  widget: Switch(
                                    activeColor: ColorConstants.secondaryColor,
                                    activeTrackColor: ColorConstants.whiteColor,
                                    inactiveTrackColor: ColorConstants
                                        .whiteLighterColor
                                        .withOpacity(0.4),
                                    inactiveThumbColor:
                                        ColorConstants.whiteLighterColor,
                                    value: fingerPrintState,
                                    onChanged: (bool value) {
                                      setState(() {
                                        fingerPrintState = value;
                                        if (fingerPrintState) {
                                          updateSettings(
                                              key: 'finger_print_login',
                                              value: '1');
                                        } else {
                                          updateSettings(
                                              key: 'finger_print_login',
                                              value: '0');
                                        }
                                      });
                                    },
                                  ),
                                  onTapped: () {}),
                              buildListTile(
                                  title: "Timeout Lock Screen",
                                  icon: Icons.lock_clock,
                                  widget: Switch(
                                    activeColor: ColorConstants.secondaryColor,
                                    activeTrackColor: ColorConstants.whiteColor,
                                    inactiveTrackColor: ColorConstants
                                        .whiteLighterColor
                                        .withOpacity(0.4),
                                    inactiveThumbColor:
                                        ColorConstants.whiteLighterColor,
                                    value: timeoutLockState,
                                    onChanged: (bool value) {
                                      setState(() {
                                        timeoutLockState = false;
                                        SharedPrefrences.addBoolToSP(
                                            "timeout_lock", timeoutLockState);
                                      });
                                    },
                                  ),
                                  onTapped: () {}),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(
      {String title, IconData icon, Function onTapped, Widget widget}) {
    return ListTile(
      tileColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Card(
        elevation: 5,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: ColorConstants.primaryGradient,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: 20,
              color: ColorConstants.white,
            ),
          ),
        ),
      ),
      title: Text(title,
          style: TextStyle(color: ColorConstants.whiteLighterColor)),
      trailing: (widget == null)
          ? Icon(Icons.arrow_forward_ios_sharp,
              size: 13, color: ColorConstants.whiteLighterColor)
          : widget,
      onTap: onTapped,
    );
  }

  _bottomSheetPinContent(BuildContext context) {
    String _oldPin = '';
    String _newPin = '';
    String _cNewPin = '';
    int pinLength = 0;
    String buttonText = 'Update';
    return Container(
      child: Column(
        children: [
          BottomSheetHeader(
            buttomSheetTitle: 'Reset Pin'.toUpperCase(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 20),
              TextStyles.textDetails(
                textSize: 16,
                textColor: ColorConstants.secondaryColor,
                textValue:
                    'The Pin you are about to reset is for your transactions',
              ),
              SizedBox(height: 15),
              NormalFields(
                maxLength: 4,
                textInputType: TextInputType.number,
                width: MediaQuery.of(context).size.width,
                hintText: 'Enter new pin',
                labelText: 'Enter New Pin',
                onChanged: (String newPin) {
                  setState(() {
                    _newPin = newPin;
                    pinLength = newPin.length;
                  });
                },
                controller: newPinController,
              ),
              SizedBox(height: 15),
              NormalFields(
                maxLength: 4,
                textInputType: TextInputType.number,
                width: MediaQuery.of(context).size.width,
                hintText: 'Confirm new pin',
                labelText: 'Confirm Pin',
                onChanged: (cNewPin) {
                  _cNewPin = cNewPin;
                },
                controller: cNewPinController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  margin: 0,
                  disableButton: true,
                  onPressed: () {
                    changePin(pinLength: pinLength);
                  },
                  text: buttonText),
            ]),
          ),
        ],
      ),
    );
  }

  _bottomSheetPasswordContent(BuildContext context) {
    String _oldPassword = '';
    String _newPassword = '';
    String _cNewPassword = '';
    int pinLength = 0;
    String buttonText = 'Update';
    return Container(
      child: Column(
        children: [
          BottomSheetHeader(
            buttomSheetTitle: 'Reset Password'.toUpperCase(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 20),
              TextStyles.textDetails(
                textSize: 15,
                textColor: ColorConstants.secondaryColor,
                textValue:
                    'The Password you are about to reset is for your Login Authentication'
                        .toUpperCase(),
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Enter old password',
                labelText: 'Enter password',
                onChanged: (oldPassword) {
                  _oldPassword = oldPassword;
                },
                controller: oldPasswordController,
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Enter new password',
                labelText: 'Enter new Password',
                onChanged: (newPassword) {
                  setState(() {
                    _newPassword = newPassword;
                    pinLength = newPassword.length;
                  });
                },
                controller: newPasswordController,
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Confirm new password',
                labelText: 'Confirm password',
                onChanged: (cNewPassword) {
                  _cNewPassword = cNewPassword;
                },
                controller: cNewPasswordController,
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                  margin: 0,
                  disableButton: true,
                  onPressed: () {
                    changePassword();
                  },
                  text: buttonText),
            ]),
          ),
        ],
      ),
    );
  }

  void changePassword() async {
    if (oldPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'old password required',
          context: context,
          bgColor: ColorConstants.primaryColor,
          scaffoldKey: _scaffoldKey);
    } else if (newPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'enter new password',
          context: context,
          bgColor: ColorConstants.primaryColor,
          scaffoldKey: _scaffoldKey);
    } else if (cNewPasswordController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'confirm new password',
          context: context,
          bgColor: ColorConstants.primaryColor,
          scaffoldKey: _scaffoldKey);
    } else if (newPasswordController.text != cNewPasswordController.text) {
      ShowSnackBar.showInSnackBar(
          value: 'password does not match',
          context: context,
          bgColor: ColorConstants.primaryColor,
          scaffoldKey: _scaffoldKey);
    } else {
      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['old_password'] = oldPasswordController.text;
        map['password'] = newPasswordController.text;
        map['repeat_password'] = cNewPasswordController.text;

        var response = await http
            .post(HttpService.rootUpdateUserPassword, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          ShowSnackBar.showInSnackBar(
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
            SharedPrefrences.addStringToSP(
                "password", newPasswordController.text);
            Future.delayed(Duration(seconds: 4), () {
              kbackBtn(context);
            });
            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            oldPasswordController.text = '';
            newPasswordController.text = '';
            cNewPasswordController.text = '';
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          ShowSnackBar.showInSnackBar(
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void updateSettings({String key, String value}) async {
    _updateState(true);

    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map[key] = value;

      print(key);
      print(value);

      var response =
          await http.post(HttpService.rootUpdateSettings, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        _updateState(false);

        ShowSnackBar.showInSnackBar(
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
          _updateState(false);

          SharedPrefrences.addStringToSP(key, value.toString());

          ShowSnackBar.showInSnackBar(
              iconData: Icons.check_circle,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        } else if (!status) {
          _updateState(false);

          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        _updateState(false);

        ShowSnackBar.showInSnackBar(
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      _updateState(false);
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void _updateState(bool state) {
    setState(() {
      updateState = state;
    });
  }

  void changePin({int pinLength}) async {
    if (oldPinController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'old pin required',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (newPinController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'enter new pin', context: context, scaffoldKey: _scaffoldKey);
    } else if (cNewPinController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'confirm new pin',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (newPinController.text != cNewPinController.text) {
      ShowSnackBar.showInSnackBar(
          value: 'pin does not match',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else {
      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['password'] = password;
        map['repeat_lock_code'] = cNewPinController.text;
        map['lock_code'] = newPinController.text;

        var response =
            await http.post(HttpService.rootUpdateUserPin, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          ShowSnackBar.showInSnackBar(
              value: 'The connection has timed out, please try again!',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          UpdatePassword settingsData = UpdatePassword.fromJson(body);

          bool status = settingsData.status;
          String message = settingsData.message;

          if (status) {
            Future.delayed(Duration(seconds: 4), () {
              kbackBtn(context);
            });
            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            cNewPinController.text = '';
            newPinController.text = '';

            SharedPrefrences.addStringToSP("lock_code", newPinController.text);
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          ShowSnackBar.showInSnackBar(
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }
}
