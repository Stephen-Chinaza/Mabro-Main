import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/create_buying_ad_page.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/create_selling_ad_page.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/buyer_details_page.dart';

import 'dart:io';

class BtcP2PBuySell extends StatefulWidget {
  @override
  _BtcP2PBuySellState createState() => _BtcP2PBuySellState();
}

class _BtcP2PBuySellState extends State<BtcP2PBuySell> {
  List<CoinList> providerImages;
  String defaultCoinImage,
      defaultCoinTitle,
      defaultCoinSubTitle,
      defaultUSDRate;
  bool SellingInputState, BuyingInputState;
  bool showSellingAds, showBuyingAds;
  bool showProgress;
  bool toogleCurrency;
  String inputCurrencyType;

  @override
  void initState() {
    super.initState();
    providerImages = DemoData.coinlists;

    defaultCoinImage = 'assets/images/btc.jpg';
    defaultCoinTitle = 'Bitcoin';
    defaultCoinSubTitle = 'BTC';
    defaultUSDRate = 'bitUSD';

    SellingInputState = false;
    BuyingInputState = false;
    showSellingAds = false;
    showBuyingAds = false;

    showProgress = false;
    toogleCurrency = true;

    inputCurrencyType = 'NGN';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'BTC P2P',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            color: ColorConstants.primaryColor,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 70,
                          width: size.width,
                          color: ColorConstants.primaryLighterColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Image.asset(
                                    defaultCoinImage,
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(width: 20),
                                  Text(defaultCoinTitle,
                                      style: TextStyle(
                                          color: ColorConstants.whiteLighterColor, fontSize: 16)),
                                ],
                              ),
                              Builder(builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    buildShowBottomSheet(
                                      context: context,
                                      bottomsheetContent:
                                          _bottomSheetContent(context),
                                    );
                                  },
                                  child: Container(
                                    child: Card(
                                        color: ColorConstants
                                            .secondaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Choose another coin',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        )),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    color: ColorConstants.primaryLighterColor,
                                  ),
                                  width: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.flag_sharp,
                                              color: Colors.green[900],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Selling price:',
                                                style: TextStyle(
                                                    color: ColorConstants.whiteLighterColor)),
                                          ],
                                        ),
                                        Divider(
                                            color: ColorConstants
                                                .whiteLighterColor),
                                        SizedBox(height: 5),
                                        Text('20,200,000.00',
                                            style: TextStyle(
                                                color: Colors.green[900],
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Text('NGN',
                                            style: TextStyle(
                                                color: ColorConstants.whiteLighterColor,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 15),
                                        CustomButton(
                                            margin: 0,
                                            height: 30,
                                            width: 95,
                                            disableButton: true,
                                            onPressed: () {
                                              setState(() {
                                                if (BuyingInputState) {
                                                  BuyingInputState = false;
                                                  SellingInputState = false;
                                                } else if (!BuyingInputState) {
                                                  BuyingInputState = true;
                                                  SellingInputState = false;
                                                } else if (SellingInputState) {
                                                  BuyingInputState = false;
                                                  SellingInputState = false;
                                                }
                                              });
                                            },
                                            text: 'Buy now'),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    color: ColorConstants.primaryLighterColor,
                                  ),
                                  width: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.flag_sharp,
                                              color: Colors.red[900],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Buying price:',
                                                style: TextStyle(
                                                    color: ColorConstants.whiteLighterColor)),
                                          ],
                                        ),
                                        Divider(
                                            color: ColorConstants
                                                .lighterSecondaryColor),
                                        SizedBox(height: 5),
                                        Text('19,780,824.14',
                                            style: TextStyle(
                                                color: Colors.red[900],
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Text('NGN',
                                            style: TextStyle(
                                                color: ColorConstants.whiteLighterColor,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 15),
                                        CustomButton(
                                            margin: 0,
                                            height: 30,
                                            width: 95,
                                            disableButton: true,
                                            onPressed: () {
                                              setState(() {
                                                if (SellingInputState) {
                                                  SellingInputState = false;
                                                  BuyingInputState = false;
                                                } else if (!SellingInputState) {
                                                  SellingInputState = true;
                                                  BuyingInputState = false;
                                                } else if (BuyingInputState) {
                                                  SellingInputState = false;
                                                  BuyingInputState = false;
                                                }
                                              });
                                            },
                                            text: 'Sell now'),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: BuyingInputState,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Amount:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (toogleCurrency) {
                                                toogleCurrency = false;
                                                inputCurrencyType = 'BTC';
                                              } else {
                                                toogleCurrency = true;
                                                inputCurrencyType = 'NGN';
                                              }
                                            });
                                          },
                                          child: Text('BTC',
                                              style: TextStyle(
                                                  color: (!toogleCurrency)
                                                      ? Colors.white
                                                      : ColorConstants
                                                          .lighterSecondaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          height: 13,
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (toogleCurrency) {
                                                toogleCurrency = false;
                                                inputCurrencyType = 'BTC';
                                              } else {
                                                toogleCurrency = true;
                                                inputCurrencyType = 'NGN';
                                              }
                                            });
                                          },
                                          child: Text('NGN',
                                              style: TextStyle(
                                                  color: (toogleCurrency)
                                                      ? Colors.white
                                                      : ColorConstants
                                                          .lighterSecondaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Card(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              onChanged: (String count) {
                                                setState(() {
                                                  int num = count.length;
                                                  if (num >= 2) {
                                                    showBuyingAds = true;
                                                    showSellingAds = false;
                                                  } else {
                                                    showBuyingAds = false;
                                                    showSellingAds = false;
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '0',
                                                counterText: "",
                                                hintStyle: TextStyle(
                                                    color: ColorConstants
                                                        .lighterSecondaryColor,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(inputCurrencyType,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Looking to buy $defaultCoinTitle?',
                                    style: TextStyle(
                                      color: ColorConstants.white,
                                      fontSize: 14,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: SellingInputState,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Amount:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (toogleCurrency) {
                                                toogleCurrency = false;
                                                inputCurrencyType = 'BTC';
                                              } else {
                                                toogleCurrency = true;
                                                inputCurrencyType = 'NGN';
                                              }
                                            });
                                          },
                                          child: Text('BTC',
                                              style: TextStyle(
                                                  color: (!toogleCurrency)
                                                      ? Colors.white
                                                      : ColorConstants
                                                          .lighterSecondaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          height: 13,
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (toogleCurrency) {
                                                toogleCurrency = false;
                                                inputCurrencyType = 'BTC';
                                              } else {
                                                toogleCurrency = true;
                                                inputCurrencyType = 'NGN';
                                              }
                                            });
                                          },
                                          child: Text('NGN',
                                              style: TextStyle(
                                                  color: (toogleCurrency)
                                                      ? Colors.white
                                                      : ColorConstants
                                                          .lighterSecondaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Card(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '0',
                                                counterText: "",
                                                hintStyle: TextStyle(
                                                    color: ColorConstants
                                                        .lighterSecondaryColor,
                                                    fontSize: 16.0),
                                              ),
                                              onChanged: (String count) {
                                                setState(() {
                                                  int num = count.length;
                                                  if (num >= 2) {
                                                    showBuyingAds = false;
                                                    showSellingAds = true;
                                                  } else {
                                                    showBuyingAds = false;
                                                    showSellingAds = false;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(inputCurrencyType,
                                              style: TextStyle(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('Looking to sell $defaultCoinTitle?',
                                        style: TextStyle(
                                          color: ColorConstants.white,
                                          fontSize: 14,
                                        )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: showProgress,
                        child: Image.asset(
                          "assets/images/loading.gif",
                          height: 50.0,
                          width: size.width,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: showBuyingAds,
                        child: Column(children: [
                          _UserAdsContainer(idColor: Colors.green[900]),
                          _UserAdsContainer(idColor: Colors.green[900]),
                          _UserAdsContainer(idColor: Colors.green[900]),
                        ]),
                      ),
                      Visibility(
                        visible: showSellingAds,
                        child: Column(children: [
                          _UserAdsContainer(idColor: Colors.red[900]),
                          _UserAdsContainer(idColor: Colors.red[900]),
                          _UserAdsContainer(idColor: Colors.red[900]),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: ColorConstants.lighterSecondaryColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                                    'Receive Bitcoin within 15 minutes or be refunded.',
                                    style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: Colors.white,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.outlined_flag_sharp,
                                    color: ColorConstants.secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('You want to buy Bitcoin?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.secondaryColor,
                                          fontSize: 18)),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _UserAdsContainer(
                                  idColor: Colors.green[900],
                                  onTap: () {
                                    kopenPage(
                                        context,
                                        BuyerDetailsPage(
                                          coinType: defaultCoinTitle,
                                          coinSign: defaultCoinSubTitle,
                                          usdRate: defaultUSDRate,
                                          sellersName: 'Emeka',
                                          btcPrice: '20,000,000 NGN/BTC',
                                          paymentMethod: 'Mabro Wallet',
                                        ));
                                  }),
                              _UserAdsContainer(idColor: Colors.green[900]),
                              _UserAdsContainer(idColor: Colors.green[900]),
                              _UserAdsContainer(idColor: Colors.green[900]),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: size.width,
                                  height: 120,
                                  child: Card(
                                    color: Colors.green[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Want better price?',
                                              style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          Spacer(),
                                          CustomButton(
                                              margin: 0,
                                              width: 220,
                                              disableButton: true,
                                              onPressed: () {
                                                kopenPage(
                                                    context,
                                                    CreateBuyingAdsPage(
                                                      coinType:
                                                          defaultCoinTitle,
                                                      coinSign:
                                                          defaultCoinSubTitle,
                                                      usdRate: defaultUSDRate,
                                                    ));
                                              },
                                              text: 'Create Your Buying Ads'),
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.outlined_flag_sharp,
                                    color: ColorConstants.secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('You want to Sell Bitcoin?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.secondaryColor,
                                          fontSize: 18)),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _UserAdsContainer(
                                  idColor: Colors.red[900],
                                  onTap: () {
                                    kopenPage(
                                        context,
                                        BuyerDetailsPage(
                                          coinType: defaultCoinTitle,
                                          coinSign: defaultCoinSubTitle,
                                          usdRate: defaultUSDRate,
                                          sellersName: 'Emeka',
                                          btcPrice: '20,000,000 NGN/BTC',
                                          paymentMethod: 'Mabro Wallet',
                                        ));
                                  }),
                              _UserAdsContainer(idColor: Colors.red[900]),
                              _UserAdsContainer(idColor: Colors.red[900]),
                              _UserAdsContainer(idColor: Colors.red[900]),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: size.width,
                                  height: 120,
                                  child: Card(
                                    color: Colors.red[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Want better price?',
                                              style: TextStyle(
                                                  color: ColorConstants.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          Spacer(),
                                          CustomButton(
                                              margin: 0,
                                              width: 220,
                                              disableButton: true,
                                              onPressed: () {
                                                kopenPage(
                                                    context,
                                                    CreateSellingAdsPage(
                                                      coinType:
                                                          defaultCoinTitle,
                                                      coinSign:
                                                          defaultCoinSubTitle,
                                                      usdRate: defaultUSDRate,
                                                    ));
                                              },
                                              text: 'Create Your Selling Ads'),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _bottomSheetContent(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select Coin',
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
          itemCount: providerImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                image: providerImages[i].image,
                title: providerImages[i].title,
                subtitle: providerImages[i].subtitle,
                rise: providerImages[i].rise,
                rate: providerImages[i].rate,
                onTapped: () {
                  kbackBtn(context);

                  setState(() {
                    defaultCoinImage = providerImages[i].image;
                    defaultCoinTitle = providerImages[i].title;
                    defaultCoinSubTitle = providerImages[i].subtitle;
                    defaultUSDRate = providerImages[i].usdRate;
                  });
                });
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
                                    color: ColorConstants.whiteLighterColor,
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
                                    color: ColorConstants.whiteLighterColor,
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

  Widget _UserAdsContainer({Color idColor, Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: 10,
                decoration: BoxDecoration(
                    color: idColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4))),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('20,000,00.00',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: idColor,
                              fontSize: 16)),
                      Text(' NGN/BTC',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.secondaryColor,
                              fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Maximum: 0.00025181 BTC',
                      style: TextStyle(
                          color: ColorConstants.lightSecondaryColor,
                          fontSize: 16)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Mabro Wallet',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.secondaryColor,
                              fontSize: 16)),
                      SizedBox(
                        width: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          showInfoDialog(
                              390.0,
                              Text(
                                  "The seller will receive NGN in their Mabro wallet. If you already have the required NGN in Mabro, the trade is instant. \n\nIf not, the trade will be completed instantly when your NGN deposit is verified by Mabro automatic system, you don't need to wait for confirmation from seller. " +
                                      "\n\nMabro can receive your NGN deposit from all banks.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 16,
                                  )));
                        },
                        child: Icon(
                          Icons.info,
                          color: ColorConstants.lighterSecondaryColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Completion time: ~0s',
                      style: TextStyle(
                          color: ColorConstants.lightSecondaryColor,
                          fontSize: 16)),
                  SizedBox(height: 5),
                  Text('chievu',
                      style: TextStyle(
                          color: ColorConstants.lightSecondaryColor,
                          fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInfoDialog(double height, Widget Widgets, {String title = 'Info'}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Stack(
              children: [
                Container(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: ColorConstants.primaryGradient),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Widgets,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
