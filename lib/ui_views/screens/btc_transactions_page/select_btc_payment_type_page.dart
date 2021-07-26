import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/deposit_and_withdraw_funds_page/deposit_withdraw.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'buy_sell_btc_page.dart';

class SelectPaymentTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TopBar(
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
            title: 'Wallet Choice',
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
              children: [
                SizedBox(height: 20),
                TextStyles.textHeadings(
                    textSize: 22,
                    textColor: Colors.black87,
                    textValue: 'How do you want to Pay?'),
                SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    kopenPage(context, SellBuyBTC(walletType: 'Naira Wallet'));
                  },
                  child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 2.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/naira.jpg',
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextStyles.textHeadings(
                                    textSize: 14,
                                    textColor: Colors.black,
                                    textValue: 'Naira Balance',
                                  ),
                                  SizedBox(height: 10),
                                  TextStyles.textHeadings(
                                    textSize: 12,
                                    textValue: 'Available: ' + '3,261.02',
                                  ),
                                ]),
                            GestureDetector(
                              onTap: () {
                                kopenPage(context, DepositWithdrawPage());
                              },
                              child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      border: Border.all(
                                          color: Colors.blueGrey, width: 0.5)),
                                  child: Center(
                                    child: Text("Top up",
                                        style:
                                            TextStyle(color: Colors.blueGrey)),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    kopenPage(context, SellBuyBTC(walletType: 'Dollar Wallet'));
                  },
                  child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 2.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/dollar.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextStyles.textHeadings(
                                    textSize: 14,
                                    textColor: Colors.black,
                                    textValue: 'Dollar Balance',
                                  ),
                                  SizedBox(height: 10),
                                  TextStyles.textHeadings(
                                    textSize: 12,
                                    textValue: 'Available: ' + '\$' + '3000',
                                  ),
                                ]),
                            GestureDetector(
                              onTap: () {
                                kopenPage(context, DepositWithdrawPage());
                              },
                              child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      border: Border.all(
                                          color: Colors.blueGrey, width: 0.5)),
                                  child: Center(
                                    child: Text("Top up",
                                        style:
                                            TextStyle(color: Colors.blueGrey)),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
