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
  String twoFactorA, setUpTouch, timeoutLock;
  bool twoFactorState, fingerPrintState, timeoutLockState;
  String user;
  bool updateState;

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
    getData();
    twoFactorState = false;
    fingerPrintState = true;
    timeoutLockState = false;
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    twoFactorA = (pref.getString('two_factor_auth') ?? '0');
    user = (pref.getString('user') ?? '');
    fingerPrintState = (pref.getBool('setup_touch') ?? true);
    timeoutLockState = (pref.getBool('timeout_lock') ?? false);

    setState(() {});
    updateSecurityState();
  }

  void updateSecurityState() {
    if (twoFactorA == '1') {
      twoFactorState = true;
    } else {
      twoFactorState = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.transparent,
        child: Column(
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
                          fontSize: 16, color: ColorConstants.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
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
                                  value: twoFactorState,
                                  onChanged: (bool value) {
                                    setState(() {
                                      twoFactorState = value;
                                      if (twoFactorState) {
                                        updateSettings(
                                            key: 'two_factor_auth', value: '1');
                                      } else {
                                        updateSettings(
                                            key: 'two_factor_auth', value: '0');
                                      }
                                    });
                                  },
                                ),
                                onTapped: () {}),
                            buildListTile(
                                title: "Setup Touch ID",
                                icon: Icons.touch_app,
                                widget: Switch(
                                  value: fingerPrintState,
                                  onChanged: (bool value) {
                                    setState(() {
                                      fingerPrintState = value;
                                      SharedPrefrences.addBoolToSP(
                                          "setup_touch", fingerPrintState);
                                    });
                                  },
                                ),
                                onTapped: () {}),
                            buildListTile(
                                title: "Timeout Lock Screen",
                                icon: Icons.lock_clock,
                                widget: Switch(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.7),
                height: 1,
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
      title: Text(title),
      trailing: (widget == null)
          ? Icon(Icons.arrow_forward_ios_sharp, size: 13)
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
              SizedBox(height: 20),
              NormalFields(
                maxLength: 4,
                textInputType: TextInputType.number,
                width: MediaQuery.of(context).size.width,
                hintText: '****** (Enter old pin)',
                labelText: 'Enter Pin',
                onChanged: (oldPin) {
                  _oldPin = oldPin;
                },
                controller: oldPinController,
              ),
              SizedBox(height: 20),
              NormalFields(
                maxLength: 4,
                textInputType: TextInputType.number,
                width: MediaQuery.of(context).size.width,
                hintText: '****** (Enter new pin)',
                labelText: 'Enter New Pin',
                onChanged: (String newPin) {
                  setState(() {
                    _newPin = newPin;
                    pinLength = newPin.length;
                  });
                },
                controller: newPinController,
              ),
              Text(''),
              SizedBox(height: 20),
              NormalFields(
                maxLength: 4,
                textInputType: TextInputType.number,
                width: MediaQuery.of(context).size.width,
                hintText: '****** (Confirm new pin)',
                labelText: 'Confirm Pin',
                onChanged: (cNewPin) {
                  _cNewPin = cNewPin;
                },
                controller: cNewPinController,
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
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

  void changePin({
    int pinLength,
  }) async {
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
    } else if (pinLength != 4) {
      ShowSnackBar.showInSnackBar(
          value: 'pin must be equal to 4 characters',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      try {
        var map = Map<String, dynamic>();
        map['user'] = user;
        map['old_pin'] = oldPinController.text;
        map['new_pin'] = newPinController.text;

        var response = await http
            .post(HttpService.rootUpdateUserPin, body: map)
            .timeout(const Duration(seconds: 15), onTimeout: () {
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
          kbackBtn(context);

          if (status) {
            String id = settingsData.data.settings.id.toString();
            bool bankState = settingsData.data.bank;
            bool userState = settingsData.data.user;

            ShowSnackBar.showInSnackBar(
                value: message, context: context, scaffoldKey: _scaffoldKey);

            //notifications data
            SharedPrefrences.addBoolToSP("bank_state", bankState);
            SharedPrefrences.addStringToSP(
                "user", settingsData.data.settings.user.toString());
            SharedPrefrences.addStringToSP("two_factor_auth",
                settingsData.data.settings.twoFactorAuth.toString());
            SharedPrefrences.addStringToSP("default_account",
                settingsData.data.settings.defaultAccount.toString());
            SharedPrefrences.addStringToSP("sell_asset_email_alert",
                settingsData.data.settings.sellAssetEmailAlert.toString());
            SharedPrefrences.addStringToSP("add_fund_email_alert",
                settingsData.data.settings.addFundEmailAlert.toString());
            SharedPrefrences.addStringToSP("buy_asset_email_alert",
                settingsData.data.settings.buyAccessEmailAlert.toString());
            SharedPrefrences.addStringToSP("login_email_alert",
                settingsData.data.settings.loginEmailAlert.toString());
            SharedPrefrences.addStringToSP("newsletter_email_alert",
                settingsData.data.settings.newsletterEmailAlert.toString());
            SharedPrefrences.addStringToSP("withdraw_fund_email_alert",
                settingsData.data.settings.withdrawFundEmailAlert.toString());

            SharedPrefrences.addStringToSP("withdraw_fund_phone_alert",
                settingsData.data.settings.withdrawFundPhoneAlert.toString());
            SharedPrefrences.addStringToSP("withdraw_fund_phone_alert",
                settingsData.data.settings.withdrawFundPhoneAlert.toString());
            SharedPrefrences.addStringToSP("sell_asset_phone_alert",
                settingsData.data.settings.sellAssetPhoneAlert.toString());
            SharedPrefrences.addStringToSP("buy_asset_phone_alert",
                settingsData.data.settings.buyAssetPhoneAlert.toString());
            SharedPrefrences.addStringToSP("newsletter_phone_alert",
                settingsData.data.settings.newsletterPhoneAlert.toString());
            SharedPrefrences.addStringToSP("add_fund_phone_alert",
                settingsData.data.settings.addFundPhoneAlert.toString());
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                bgColor: ColorConstants.primaryColor,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          ShowSnackBar.showInSnackBar(
              value: 'network error',
              context: context,
              bgColor: ColorConstants.primaryColor,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            bgColor: ColorConstants.primaryColor,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
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
                textSize: 16,
                textColor: ColorConstants.secondaryColor,
                textValue:
                    'The Password you are about to reset is for your Login Authentication'
                        .toUpperCase(),
              ),
              SizedBox(height: 20),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: '****** (Enter old password)',
                labelText: 'Enter password',
                onChanged: (oldPassword) {
                  _oldPassword = oldPassword;
                },
                controller: oldPasswordController,
              ),
              SizedBox(height: 20),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: '****** (Enter new password)',
                labelText: 'Enter new Password',
                onChanged: (newPassword) {
                  setState(() {
                    _newPassword = newPassword;
                    pinLength = newPassword.length;
                  });
                },
                controller: newPasswordController,
              ),
              Text(''),
              SizedBox(height: 20),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: '****** (Confirm new password)',
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
                    changePassword(pinLength: pinLength);
                  },
                  text: buttonText),
            ]),
          ),
        ],
      ),
    );
  }

  void changePassword({
    int pinLength,
  }) async {
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
        map['user'] = user;
        map['old_password'] = oldPasswordController.text;
        map['new_password'] = newPasswordController.text;

        var response = await http
            .post(HttpService.rootUpdateUserPassword, body: map)
            .timeout(const Duration(seconds: 15), onTimeout: () {
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
            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
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
      map['user'] = user;
      map[key] = value;

      var response = await http
          .post(HttpService.rootUpdateSettings, body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
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

          SharedPrefrences.addStringToSP(key, value);

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
}
