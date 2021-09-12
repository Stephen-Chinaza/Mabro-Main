import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/p2p_buy_sell_page.dart';
import 'package:mabro/ui_views/screens/recieve_btc_page/recieve_btc_page.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';

class Trades extends StatefulWidget {
  Trades({Key key}) : super(key: key);

  @override
  _TradesState createState() => _TradesState();
}

class _TradesState extends State<Trades> {
  int _selectedIndex = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: TopBar(
        title: 'Trades',
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text('1 BTC/USD ',
                    style: TextStyle(
                      color: ColorConstants.whiteLighterColor,
                      fontSize: 14,
                    )),
                SizedBox(
                  height: 15,
                ),
                Text('\$15 476.88',
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('+1.08 ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        )),
                    Icon(Icons.arrow_downward, color: Colors.red, size: 12)
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                    child: Image.asset(
                  'assets/images/btc.jpg',
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                )),
                SizedBox(
                  height: 35,
                ),
                Card(
                  color: ColorConstants.primaryLighterColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your BTC Balance',
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        color: ColorConstants.whiteLighterColor,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '0.0000637738',
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: ColorConstants.whiteColor,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'USD',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    color: ColorConstants.whiteLighterColor,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '\$1 475.0',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: ColorConstants.whiteColor),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent: _bottomSheetContent(context),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            height: 50,
                            color: Colors.transparent,
                            child: Card(
                              color: Colors.green.shade900,
                              child: Center(
                                child: Text(
                                  'BUY BTC',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: ColorConstants.whiteColor),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent: _bottomSheetContent(context),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            height: 50,
                            color: Colors.transparent,
                            child: Card(
                              color: Colors.red.shade900,
                              child: Center(
                                child: Text(
                                  'SELL BTC',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: ColorConstants.whiteColor),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetContent(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select'.toUpperCase(),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildCarrierList(),
        ]),
      ],
    );
  }

  Widget _buildCarrierList() {
    return Container(
      child: ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    kbackBtn(context);
                    kopenPage(context, ReceiveBtcPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      child: Text(
                        'Send or Receive with address',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: ColorConstants.whiteLighterColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: ColorConstants.whiteLighterColor,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    kbackBtn(context);
                    kopenPage(context, BtcP2PBuySell());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      child: Text(
                        'P2P',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: ColorConstants.whiteLighterColor),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: ColorConstants.whiteLighterColor,
                ),
              ],
            );
          }),
    );
  }

  Widget buildListTile(
      {String title,
      String subtitle,
      String rise,
      String rate,
      String image,
      Function onTapped}) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(image, width: 20, height: 20),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: size.width - 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$title',
                                style: TextStyle(
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text('$subtitle',
                                style: TextStyle(
                                    color: ColorConstants.lighterSecondaryColor,
                                    fontSize: 14)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$rate',
                                style: TextStyle(
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            Text('$rise',
                                style: TextStyle(
                                    color: ColorConstants.lighterSecondaryColor,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.7),
          height: 0.5,
        ),
      ],
    );
  }
}
