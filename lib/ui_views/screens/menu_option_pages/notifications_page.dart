import 'dart:convert';
import 'dart:io';

import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String user;

  bool pAddFundState,
      pWithdrawFundState,
      pBuyFundState,
      pSellAsset,
      pNewsLetter;
  bool loginState,
      eAddFundState,
      eWithdrawFundState,
      eBuyFundState,
      eSellAsset,
      eNewsLetter;
  bool smsAlertState;
  String wfpa,
      sapa,
      bapa,
      afpa,
      npa,
      lea,
      afea,
      wfea,
      baea,
      saea,
      nea,
      smsalert;

  bool updateState;

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    wfpa = (pref.getString('withdraw_fund_phone_alert') ?? null); //
    sapa = (pref.getString('sell_asset_phone_alert') ?? null); //
    bapa = (pref.getString('buy_asset_phone_alert') ?? null); //
    afpa = (pref.getString('add_fund_phone_alert') ?? null); //
    npa = (pref.getString('newsletter_phone_alert') ?? null); //
    lea = (pref.getString('login_email_alert') ?? null); //
    afea = (pref.getString('add_fund_email_alert') ?? null); //
    wfea = (pref.getString('withdraw_fund_email_alert') ?? null); //
    baea = (pref.getString('buy_asset_email_alert') ?? null); //
    saea = (pref.getString('sell_asset_email_alert') ?? null); //
    nea = (pref.getString('newsletter_email_alert') ?? null); //
    smsalert = (pref.getString('sms_alert') ?? null); //
    user = (pref.getString('user') ?? null); //

    updateNotificationState();
    setState(() {});
  }

  void updateNotificationState() {
    setState(() {
      if (wfpa == '1') {
        pWithdrawFundState = true;
      } else {
        pWithdrawFundState = false;
      }

      if (sapa == '1') {
        pSellAsset = true;
      } else {
        pSellAsset = false;
      }

      if (bapa == '1') {
        pBuyFundState = true;
      } else {
        pBuyFundState = false;
      }

      if (afpa == '1') {
        pAddFundState = true;
      } else {
        pAddFundState = false;
      }

      if (npa == '1') {
        pNewsLetter = true;
      } else {
        pNewsLetter = false;
      }

      if (lea == '1') {
        loginState = true;
      } else {
        loginState = false;
      }

      if (afea == '1') {
        eAddFundState = true;
      } else {
        eAddFundState = false;
      }

      if (wfea == '1') {
        eWithdrawFundState = true;
      } else {
        eWithdrawFundState = false;
      }

      if (baea == '1') {
        eBuyFundState = true;
      } else {
        eBuyFundState = false;
      }

      if (saea == '1') {
        eSellAsset = true;
      } else {
        eSellAsset = false;
      }

      if (nea == '1') {
        eNewsLetter = true;
      } else {
        eNewsLetter = false;
      }
      if (smsalert == '1') {
        smsAlertState = true;
      } else {
        smsAlertState = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    pAddFundState = false;
    pWithdrawFundState = false;
    pBuyFundState = false;
    pSellAsset = false;
    pNewsLetter = false;

    loginState = false;
    eAddFundState = false;
    eWithdrawFundState = false;
    eBuyFundState = false;
    eSellAsset = false;
    eNewsLetter = false;

    smsAlertState = false;

    updateState = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        title: 'Notifications',
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(child: _buidNoticationBody()),
    );
  }

  Widget _buidNoticationBody() {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text(
                      "Push Notifications",
                      style: GoogleFonts.openSans(
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    )),
                Column(
                  children: <Widget>[
                    ...ListTile.divideTiles(
                      color: Colors.grey,
                      tiles: [
                        buildListTile(
                            title: "Add fund",
                            widget: Switch(
                              value: pAddFundState,
                              onChanged: (bool value) {
                                setState(() {
                                  pAddFundState = value;
                                  if (pAddFundState) {
                                    updateSettings(
                                        key: 'add_fund_phone_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'add_fund_phone_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Sms alert",
                            widget: Switch(
                              value: smsAlertState,
                              onChanged: (bool value) {
                                setState(() {
                                  smsAlertState = value;
                                  if (smsAlertState) {
                                    updateSettings(
                                        key: 'sms_alert', value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'sms_alert', value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Withdraw fund",
                            widget: Switch(
                              value: pWithdrawFundState,
                              onChanged: (bool value) {
                                setState(() {
                                  pWithdrawFundState = value;

                                  if (pWithdrawFundState) {
                                    updateSettings(
                                        key: 'withdraw_fund_phone_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'withdraw_fund_phone_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Buy asset",
                            widget: Switch(
                              value: pBuyFundState,
                              onChanged: (bool value) {
                                setState(() {
                                  pBuyFundState = value;

                                  if (pBuyFundState) {
                                    updateSettings(
                                        key: 'buy_asset_phone_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'buy_asset_phone_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Sell asset",
                            widget: Switch(
                              value: pSellAsset,
                              onChanged: (bool value) {
                                setState(() {
                                  pSellAsset = value;
                                  if (pSellAsset) {
                                    updateSettings(
                                        key: 'sell_asset_phone_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'sell_asset_phone_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "News letter",
                            widget: Switch(
                              value: pNewsLetter,
                              onChanged: (bool value) {
                                setState(() {
                                  pNewsLetter = value;
                                  if (pNewsLetter) {
                                    updateSettings(
                                        key: 'newsletter_phone_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'newsletter_phone_alert',
                                        value: null);
                                  }
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
          Divider(
            height: 0,
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text(
                      "Email notifications",
                      style: GoogleFonts.openSans(
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    )),
                Column(
                  children: <Widget>[
                    ...ListTile.divideTiles(
                      color: Colors.grey,
                      tiles: [
                        buildListTile(
                            title: "Login notification",
                            widget: Switch(
                              value: loginState,
                              onChanged: (bool value) {
                                setState(() {
                                  loginState = value;

                                  if (loginState) {
                                    updateSettings(
                                        key: 'login_email_alert', value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'login_email_alert', value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Add fund",
                            widget: Switch(
                              value: eAddFundState,
                              onChanged: (bool value) {
                                setState(() {
                                  eAddFundState = value;

                                  if (eAddFundState) {
                                    updateSettings(
                                        key: 'add_fund_email_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'add_fund_email_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Withdraw fund",
                            widget: Switch(
                              value: eWithdrawFundState,
                              onChanged: (bool value) {
                                setState(() {
                                  eWithdrawFundState = value;

                                  if (eWithdrawFundState) {
                                    updateSettings(
                                        key: 'withdraw_fund_email_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'withdraw_fund_email_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Buy asset",
                            widget: Switch(
                              value: eBuyFundState,
                              onChanged: (bool value) {
                                setState(() {
                                  eBuyFundState = value;

                                  if (eBuyFundState) {
                                    updateSettings(
                                        key: 'buy_asset_email_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'buy_asset_email_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "Sell asset",
                            widget: Switch(
                              value: eSellAsset,
                              onChanged: (bool value) {
                                setState(() {
                                  eSellAsset = value;

                                  if (eSellAsset) {
                                    updateSettings(
                                        key: 'sell_asset_email_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'sell_asset_email_alert',
                                        value: null);
                                  }
                                });
                              },
                            ),
                            onTapped: () {}),
                        buildListTile(
                            title: "News letter",
                            widget: Switch(
                              value: eNewsLetter,
                              onChanged: (bool value) {
                                setState(() {
                                  eNewsLetter = value;

                                  if (eNewsLetter) {
                                    updateSettings(
                                        key: 'newsletter_email_alert',
                                        value: '1');
                                  } else {
                                    updateSettings(
                                        key: 'newsletter_email_alert',
                                        value: null);
                                  }
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              color: Colors.grey.withOpacity(0.7),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(
      {String title, IconData icon, Function onTapped, Widget widget}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      title: Text(title),
      trailing: (widget == null)
          ? Icon(Icons.arrow_forward_ios_sharp, size: 13)
          : widget,
      onTap: onTapped,
    );
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

          //String code = regUser.data.code;

          ShowSnackBar.showInSnackBar(
              iconData: Icons.check_circle,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);

          setState(() {
            SharedPrefrences.addStringToSP(key, value);
          });
        } else if (!status) {
          _updateState(false);

          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        _updateState(false);

        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      _updateState(false);
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
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
