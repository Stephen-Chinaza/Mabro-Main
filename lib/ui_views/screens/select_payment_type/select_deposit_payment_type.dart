import 'dart:convert';
import 'dart:io';

import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';

import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/flutterwave_payment/flutterwave_payment.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';

import 'package:mabro/res/colors.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SelectDepositPaymentTypePage extends StatefulWidget {
  final int amount;

  const SelectDepositPaymentTypePage({Key key, this.amount}) : super(key: key);
  @override
  _SelectDepositPaymentTypePageState createState() =>
      _SelectDepositPaymentTypePageState();
}

class _SelectDepositPaymentTypePageState
    extends State<SelectDepositPaymentTypePage> {
  String email, userId;
  bool pageState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = (pref.getString('email_address') ?? '');
    userId = (pref.getString('userId') ?? '');
  }

  @override
  void initState() {
    super.initState();

    getData();
    pageState = false;
    print(widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
            backgroundColor: ColorConstants.primaryColor,
            key: _scaffoldKey,
            appBar: TopBar(
              backgroundColorStart: ColorConstants.primaryColor,
              backgroundColorEnd: ColorConstants.secondaryColor,
              icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              title: 'Make Payment',
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            body: (pageState)
                ? loadingPage(state: pageState)
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        child: Card(
                      color: ColorConstants.primaryLighterColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'How would you like to add money to your Mabro wallet?',
                                style: TextStyle(
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 20)),
                          ),
                          SizedBox(height: 10),
                          // GestureDetector(
                          //   onTap: () {
                          //   },
                          //   child: Container(
                          //       height: 70,
                          //       color: Colors.white,
                          //       child: Card(
                          //         elevation: 3,
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.start,
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Image.asset(
                          //                 'assets/images/monnify.png',
                          //                 height: 30,
                          //                 width: 30,
                          //                 fit: BoxFit.contain,
                          //               ),
                          //             ),
                          //             SizedBox(width: 10),
                          //             Container(
                          //               color: ColorConstants
                          //                   .lighterSecondaryColor
                          //                   .withOpacity(0.3),
                          //               height: 70,
                          //               width: 0.5,
                          //             ),
                          //             SizedBox(width: 10),
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Text(
                          //                   'Instant payment with Monnify',
                          //                   style: TextStyle(
                          //                       color: Colors.black,
                          //                       fontSize: 14)),
                          //             ),
                          //           ],
                          //         ),
                          //       )),
                          // ),
                          SizedBox(height: 10),

                          Divider(
                            color: ColorConstants.whiteLighterColor,
                          ),
                          GestureDetector(
                            onTap: () async {
                              kopenPage(
                                  context,
                                  CardPayment(
                                    amount: widget.amount,
                                  ));
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                height: 80,
                                child: Card(
                                  color: Colors.purple[900],
                                  elevation: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/flutterwave.png',
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        color: ColorConstants.whiteLighterColor
                                            .withOpacity(0.3),
                                        height: 70,
                                        width: 0.5,
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Instant payment with FlutterWave',
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.whiteColor,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
                  )),
      ],
    );
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void redirectPage() {
    Future.delayed(Duration(seconds: 2), () {
      kopenPage(context, LandingPage());
    });
  }
}
