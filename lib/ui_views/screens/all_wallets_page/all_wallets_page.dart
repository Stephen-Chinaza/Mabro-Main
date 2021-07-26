import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/screens/deposit_and_withdraw_funds_page/deposit_withdraw.dart';
import 'package:mabro/ui_views/screens/recieve_btc_page/recieve_btc_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllWalletPage extends StatefulWidget {
  @override
  _AllWalletPageState createState() => _AllWalletPageState();
}

class _AllWalletPageState extends State<AllWalletPage> {
  bool nairaState = true;
  bool dollarState = false;

  String nairaBalance = '';
  String combinedBalance = '0.00';
  String btcBalance = '';

  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nairaBalance = (pref.getString('naria_balance') ?? '');
    btcBalance = (pref.getString('bitcoin_balance') ?? '');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar(
        title: 'All Wallets',
        onPressed: null,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(gradient: ColorConstants.primaryGradient),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              color: Colors.white,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width,
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'NGN $combinedBalance',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Combined Wallet Value',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Wallet allows you to organise your funds into categories, like spending and savings.',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Local Currency',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.grey.shade200,
                                    offset: Offset(3, 3))
                              ],
                              border: Border.all(
                                  color:
                                      Colors.grey.shade200, // Set border color
                                  width: 1.0), // Set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  7.0)), // Set rounded corner radius
                              // Make rounded corner of border
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Naira Wallet',
                                          style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade500,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                        Image.asset('assets/images/naira.jpg',
                                            height: 35, width: 35)
                                      ],
                                    ),
                                    Divider(),
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          nairaBalance,
                                          style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            kopenPage(
                                                context, DepositWithdrawPage());
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                gradient: ColorConstants
                                                    .primaryGradient),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Center(
                                                child: Text(
                                                  'Add cash',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Crypto Currencies',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        _cryptoWallets(
                            size: size,
                            onTap: () {
                              kopenPage(context, ReceiveBtcPage());
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '**More wallets coming soon**',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        )),
      ),
    );
  }

  Widget _cryptoWallets(
      {Size size,
      String wallet_title,
      String img_url,
      Color color,
      Function onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey.shade200,
                  offset: Offset(3, 3))
            ],
            border: Border.all(
                color: Colors.grey.shade200, // Set border color
                width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BTC Wallet',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Image.asset('assets/images/btc.jpg',
                          height: 25, width: 25)
                    ],
                  ),
                  Divider(),
                  Text(
                    'Balance',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        btcBalance,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        '\$10.545',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NGN 24,000.00',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        '+ 2.09',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.green.shade900,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
