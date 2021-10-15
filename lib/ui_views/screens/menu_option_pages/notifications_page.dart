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

  String userId;

  bool smsState,emailState,newsletterState;
  String sms, emailTransactionNotify,twoFactorAuth,fingerPrintLogin,newsletter;

  bool updateStatePN, updateStateE;

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    sms = (pref.getString('sms_notification') ?? ''); //
    emailTransactionNotify = (pref.getString('email_transaction_notification') ?? ''); //
    newsletter = (pref.getString('newsletter') ?? ''); //
    userId = (pref.getString('userId') ?? ''); //

    updateNotificationState();


  }

  void updateNotificationState() {
    setState(() {
      if (sms == '1') {
        smsState = true;
      } else {
        smsState = false;
      }

      if (emailTransactionNotify == '1') {
        emailState = true;
      } else {
        emailState = false;
      }
      if (newsletter == '1') {
        newsletterState = true;
      } else {
        newsletterState = false;
      }

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    smsState = false;
    emailState = false;
    newsletterState = false;

    getData().whenComplete(() => {
      setState(()
      {}),
    }
    );

    updateStatePN = false;
    updateStateE = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
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
            color: ColorConstants.primaryLighterColor,
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Text(
                          "Push Notifications",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: ColorConstants.whiteColor,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,

                        )),
                    Visibility(
                      visible: updateStatePN,
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
                  ],
                ),
                Column(
                  children: <Widget>[

                    // buildListTile(
                    //     title: "Add fund",
                    //     widget: Switch(
                    //       activeColor: ColorConstants.secondaryColor,
                    //       activeTrackColor: ColorConstants.whiteColor,
                    //       inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
                    //       inactiveThumbColor: ColorConstants.whiteLighterColor,
                    //       value: pAddFundState,
                    //       onChanged: (bool value) {
                    //         setState(() {
                    //           pAddFundState = value;
                    //           if (pAddFundState) {
                    //             updateSettings(
                    //                 key: 'add_fund_phone_alert',
                    //                 value: '1',
                    //                 num: 1);
                    //           } else {
                    //             updateSettings(
                    //                 key: 'add_fund_phone_alert',
                    //                 value: null,
                    //                 num: 1);
                    //           }
                    //         });
                    //       },
                    //     ),
                    //     onTapped: () {}),
                    buildListTile(
                        title: "Sms alert",
                        widget: Switch(
                          activeColor: ColorConstants.secondaryColor,
                          activeTrackColor: ColorConstants.whiteColor,
                          inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
                          inactiveThumbColor: ColorConstants.whiteLighterColor,
                          value: smsState,
                          onChanged: (bool value) {
                            setState(() {
                              smsState = value;
                              if (smsState) {
                                updateSettings(
                                    key: 'sms_notification', value: '1',
                                    num: 1);
                              } else {
                                updateSettings(
                                    key: 'sms_notification', value: '0',
                                    num: 1);
                              }
                            });
                          },
                        ),
                        onTapped: () {}),
                    buildListTile(
                        title: "Email transaction notification",
                        widget: Switch(
                          activeColor: ColorConstants.secondaryColor,
                          activeTrackColor: ColorConstants.whiteColor,
                          inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
                          inactiveThumbColor: ColorConstants.whiteLighterColor,
                          value: emailState,
                          onChanged: (bool value) {
                            setState(() {
                              emailState = value;

                              if (emailState) {
                                updateSettings(
                                    key: 'email_transaction_notification',
                                    value: '1',
                                    num: 1);
                              } else {
                                updateSettings(
                                    key: 'email_transaction_notification',
                                    value: '0',
                                    num: 1);
                              }
                            });
                          },
                        ),
                        onTapped: () {}),
                    // buildListTile(
                    //     title: "Buy asset",
                    //     widget: Switch(
                    //       activeColor: ColorConstants.secondaryColor,
                    //       activeTrackColor: ColorConstants.whiteColor,
                    //       inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
                    //       inactiveThumbColor: ColorConstants.whiteLighterColor,
                    //       value: pBuyFundState,
                    //       onChanged: (bool value) {
                    //         setState(() {
                    //           pBuyFundState = value;
                    //
                    //           if (pBuyFundState) {
                    //             updateSettings(
                    //                 key: 'buy_asset_phone_alert',
                    //                 value: '1',
                    //                 num: 1);
                    //           } else {
                    //             updateSettings(
                    //                 key: 'buy_asset_phone_alert',
                    //                 value: null,
                    //                 num: 1);
                    //           }
                    //         });
                    //       },
                    //     ),
                    //     onTapped: () {}),
                    // buildListTile(
                    //     title: "Sell asset",
                    //     widget: Switch(
                    //       activeColor: ColorConstants.secondaryColor,
                    //       activeTrackColor: ColorConstants.whiteColor,
                    //       inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
                    //       inactiveThumbColor: ColorConstants.whiteLighterColor,
                    //       value: pSellAsset,
                    //       onChanged: (bool value) {
                    //         setState(() {
                    //           pSellAsset = value;
                    //           if (pSellAsset) {
                    //             updateSettings(
                    //                 key: 'sell_asset_phone_alert',
                    //                 value: '1',
                    //                 num: 1);
                    //           } else {
                    //             updateSettings(
                    //                 key: 'sell_asset_phone_alert',
                    //                 value: null,
                    //                 num: 1);
                    //           }
                    //         });
                    //       },
                    //     ),
                    //     onTapped: () {}),
                    buildListTile(
                        title: "News letter",
                        widget: Switch(
                          activeColor: ColorConstants.secondaryColor,
                          activeTrackColor: ColorConstants.whiteColor,
                          inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
                          inactiveThumbColor: ColorConstants.whiteLighterColor,
                          value: newsletterState,
                          onChanged: (bool value) {
                            setState(() {
                              newsletterState = value;
                              if (newsletterState) {
                                updateSettings(
                                    key: 'newsletter',
                                    value: '1',
                                    num: 1);
                              } else {
                                updateSettings(
                                    key: 'newsletter',
                                    value: '0',
                                    num: 1);
                              }
                            });
                          },
                        ),
                        onTapped: () {}),

                  ],
                ),
              ],
            ),
          ),

          // Card(
          //   elevation: 3,
          //   color: ColorConstants.primaryLighterColor,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Container(
          //               alignment: Alignment.topLeft,
          //               padding: EdgeInsets.only(top: 15, left: 15, right: 15),
          //               child: Text(
          //                 "Email notifications",
          //                 style: TextStyle(
          //                     fontStyle: FontStyle.normal,
          //                     fontSize: 16,
          //                     color: ColorConstants.white,
          //                     fontWeight: FontWeight.w600),
          //                 textAlign: TextAlign.left,
          //               )),
          //           Visibility(
          //             visible: updateStateE,
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   Text(
          //                     'updating...',
          //                     style: TextStyle(
          //                         fontSize: 16, color: ColorConstants.secondaryColor),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Column(
          //         children: <Widget>[
          //
          //               buildListTile(
          //                   title: "Login notification",
          //                   widget: Switch(
          //                     activeColor: ColorConstants.secondaryColor,
          //                     activeTrackColor: ColorConstants.whiteColor,
          //                     inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
          //                     inactiveThumbColor: ColorConstants.whiteLighterColor,
          //                     value: loginState,
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         loginState = value;
          //
          //                         if (loginState) {
          //                           updateSettings(
          //                               key: 'login_email_alert', value: '1',
          //                               num: 2);
          //                         } else {
          //                           updateSettings(
          //                               key: 'login_email_alert', value: null,
          //                               num: 2);
          //                         }
          //                       });
          //                     },
          //                   ),
          //                   onTapped: () {}),
          //               buildListTile(
          //                   title: "Add fund",
          //                   widget: Switch(
          //                     activeColor: ColorConstants.secondaryColor,
          //                     activeTrackColor: ColorConstants.whiteColor,
          //                     inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
          //                     inactiveThumbColor: ColorConstants.whiteLighterColor,
          //                     value: eAddFundState,
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         eAddFundState = value;
          //
          //                         if (eAddFundState) {
          //                           updateSettings(
          //                               key: 'add_fund_email_alert',
          //                               value: '1',
          //                               num: 2);
          //                         } else {
          //                           updateSettings(
          //                               key: 'add_fund_email_alert',
          //                               value: null,
          //                               num: 2);
          //                         }
          //                       });
          //                     },
          //                   ),
          //                   onTapped: () {}),
          //               buildListTile(
          //                   title: "Withdraw fund",
          //                   widget: Switch(
          //                     activeColor: ColorConstants.secondaryColor,
          //                     activeTrackColor: ColorConstants.whiteColor,
          //                     inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
          //                     inactiveThumbColor: ColorConstants.whiteLighterColor,
          //                     value: eWithdrawFundState,
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         eWithdrawFundState = value;
          //
          //                         if (eWithdrawFundState) {
          //                           updateSettings(
          //                               key: 'withdraw_fund_email_alert',
          //                               value: '1',
          //                               num: 2);
          //                         } else {
          //                           updateSettings(
          //                               key: 'withdraw_fund_email_alert',
          //                               value: null,
          //                               num: 2);
          //                         }
          //                       });
          //                     },
          //                   ),
          //                   onTapped: () {}),
          //               buildListTile(
          //                   title: "Buy asset",
          //                   widget: Switch(
          //                     activeColor: ColorConstants.secondaryColor,
          //                     activeTrackColor: ColorConstants.whiteColor,
          //                     inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
          //                     inactiveThumbColor: ColorConstants.whiteLighterColor,
          //                     value: eBuyFundState,
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         eBuyFundState = value;
          //
          //                         if (eBuyFundState) {
          //                           updateSettings(
          //                               key: 'buy_asset_email_alert',
          //                               value: '1');
          //                         } else {
          //                           updateSettings(
          //                               key: 'buy_asset_email_alert',
          //                               value: null,
          //                               num: 2);
          //                         }
          //                       });
          //                     },
          //                   ),
          //                   onTapped: () {}),
          //               buildListTile(
          //                   title: "Sell asset",
          //                   widget: Switch(
          //                     activeColor: ColorConstants.secondaryColor,
          //                     activeTrackColor: ColorConstants.whiteColor,
          //                     inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
          //                     inactiveThumbColor: ColorConstants.whiteLighterColor,
          //                     value: eSellAsset,
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         eSellAsset = value;
          //
          //                         if (eSellAsset) {
          //                           updateSettings(
          //                               key: 'sell_asset_email_alert',
          //                               value: '1',
          //                               num: 2);
          //                         } else {
          //                           updateSettings(
          //                               key: 'sell_asset_email_alert',
          //                               value: null,
          //                               num: 2);
          //                         }
          //                       });
          //                     },
          //                   ),
          //                   onTapped: () {}),
          //               buildListTile(
          //                   title: "News letter",
          //                   widget: Switch(
          //                     activeColor: ColorConstants.secondaryColor,
          //                     activeTrackColor: ColorConstants.whiteColor,
          //                     inactiveTrackColor: ColorConstants.whiteLighterColor.withOpacity(0.4),
          //                     inactiveThumbColor: ColorConstants.whiteLighterColor,
          //                     value: eNewsLetter,
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         eNewsLetter = value;
          //
          //                         if (eNewsLetter) {
          //                           updateSettings(
          //                               key: 'newsletter_email_alert',
          //                               value: '1',
          //                               num: 2
          //                           );
          //                         } else {
          //                           updateSettings(
          //                               key: 'newsletter_email_alert',
          //                               value: null,
          //                               num: 2);
          //                         }
          //                       });
          //                     },
          //                   ),
          //                   onTapped: () {}),
          //
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

        ],
      ),
    );
  }

  ListTile buildListTile(
      {String title, IconData icon, Function onTapped, Widget widget, int num}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      title: Text(title, style: TextStyle(color: ColorConstants.whiteLighterColor)),
      trailing: (widget == null)
          ? Icon(Icons.arrow_forward_ios_sharp, size: 13)
          : widget,
      onTap: onTapped,
    );
  }

  void updateSettings({String key, String value, int num}) async {
    _updateState(true, num);

    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map[key] = value;

      var response = await http
          .post(HttpService.rootUpdateSettings, body: map, headers: {
        'Authorization': 'Bearer '+HttpService.token,
      })
          .timeout(const Duration(seconds: 15), onTimeout: () {
        _updateState(false, num);

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
          _updateState(false,num);


          ShowSnackBar.showInSnackBar(
              iconData: Icons.check_circle,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);

          setState(() {
            SharedPrefrences.addStringToSP(key, value.toString());
          });
        } else if (!status) {
          _updateState(false, num);

          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        _updateState(false, num);

        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      _updateState(false, num);
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void _updateState(bool state, int num) {
    setState(() {
      if(num == 1){
        updateStatePN = state;
      }else if(num == 2){

        updateStateE = state;}
    });
  }
}
