import 'dart:io';
import 'dart:math';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/transaction_container.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BtcOptionsSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 90),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                    kbackBtn(context);

                                },
                                child: Icon(
                                  Platform.isIOS
                                      ? Icons.arrow_back_ios
                                      : Icons.arrow_back,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/btc.jpg',
                                fit: BoxFit.contain, height: 60, width: 60),
                            SizedBox(height: 10),
                            Text(
                              'BTC 0.00',
                              style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'BTC WALLET',
                              style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                color: Colors.orange,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                top: 220,
                left: 10,
                right: 10,
                child: Card(
                  child: Container(
                    height: 90,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.money,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: ColorConstants.transparent,
                                    child: Center(
                                      child: Text(
                                        'Buy'.toUpperCase(),
                                        style: GoogleFonts.openSans(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.satellite,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: ColorConstants.transparent,
                                    child: Center(
                                      child: Text(
                                        'Sell'.toUpperCase(),
                                        style: GoogleFonts.openSans(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.send_and_archive,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: ColorConstants.transparent,
                                    child: Center(
                                      child: Text(
                                        'Send'.toUpperCase(),
                                        style: GoogleFonts.openSans(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.receipt,
                                  size: 30,
                                   color: Colors.red[800],
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: ColorConstants.transparent,
                                    child: Center(
                                      child: Text(
                                        'Recieve'.toUpperCase(),
                                        style: GoogleFonts.openSans(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Visibility(
              child: Column(
            children: [
              Image.asset('assets/images/nodata.png', height: 200, width: 200),
              SizedBox(height: 10),
              TextStyles.textDetails(
                textSize: 14,
                textColor: Colors.grey.withOpacity(0.8),
                textValue: "You don't have any pending transactions yet",
              ),
            ],
          )),
          Visibility(
            visible: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                TextStyles.textDetails(
                  textSize: 14,
                  textColor: Colors.black.withOpacity(0.8),
                  textValue: "Transactions History",
                ),
                SizedBox(height: 10),
                TransactionContainer(
                  amount: 'NGN200',
                  icon: Icons.help,
                  transactionName: 'Purchased BTC',
                  date: '11/9/2020',
                ),
            ],
          ),
              )),
        ],
      ),
      bottomSheet:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
                    margin: 0,
                    disableButton: true,
                    onPressed: () {},
                    text: 'BUY BITCOIN'),
      ),
    );
  }
}
