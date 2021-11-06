import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/models/p2p_models/list_coins.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:majascan/majascan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:share/share.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CoinExchange extends StatefulWidget {
  final String coinName;
  final String coinTitle,
      exchangeRate,
      defaultCurrency,
      buyingPrice,
      sellingPrice,
      usdBuyingPrice,
      usdSellingPrice,
      coinImage,
      coinSign;
  const CoinExchange(
      {Key key,
      this.coinName,
      this.coinTitle,
      this.exchangeRate,
      this.defaultCurrency,
      this.buyingPrice,
      this.sellingPrice,
      this.usdBuyingPrice,
      this.usdSellingPrice,
      this.coinImage,
      this.coinSign})
      : super(key: key);

  @override
  _CoinExchangeState createState() => _CoinExchangeState();
}

class _CoinExchangeState extends State<CoinExchange>
    with SingleTickerProviderStateMixin {
  String coinName = '';
  String userId = '';
  TabController _tabController;
  int activeTabIndex = 0;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //Barcode result;
  QRViewController controller;
  BuildContext dialogContext;

  var formatter = NumberFormat("#,##0.00", "en_US");

  String result = "Hey there !";
  String scanResult = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController btcAddressController = TextEditingController();

  Future _scanQR() async {
    try {
      String qrResult = await MajaScan.startScan(
          title: 'Scan Code',
          barColor: ColorConstants.primaryLighterColor,
          titleColor: Colors.white,
          qRCornerColor: ColorConstants.secondaryColor,
          qRScannerColor: ColorConstants.primaryColor,
          flashlightEnable: true,
          scanAreaScale: 0.7);
      setState(() {
        result = qrResult;
        scanResult = qrResult;
        btcAddressController.text = scanResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String title;
  String walletAddress;
  bool hideScanner;
  final dialogContextCompleter = Completer<BuildContext>();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();

    getData();
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    walletAddress = (pref.getString('bitcoin_address') ??
        '3FZbgi29cpjq2GjdwV8eyHuJJnKLtktZc5');

    setState(() {});
  }

  String defaultCoinImage,
      defaultCoinTitle,
      defaultCoinSubTitle,
      defaultUSDRate,
      defaultBuyingPrice,
      defaultSellingPrice,
      defaultusdBuyingPrice,
      defaultusdSellingPrice;

  String priceType;

  List<CoinList> providerImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(int.tryParse('3.5'));
    getData().then((value) => {
          userId = userId,
        });
    providerImages = DemoData.coinlists;
    coinName = widget.coinName;
    defaultCoinImage = widget.coinImage;
    defaultCoinTitle = widget.coinName.toUpperCase();
    defaultCoinSubTitle = widget.coinSign;
    defaultUSDRate = widget.exchangeRate;
    defaultSellingPrice = widget.sellingPrice;
    defaultBuyingPrice = widget.buyingPrice;
    defaultusdBuyingPrice = widget.usdBuyingPrice;
    defaultusdSellingPrice = widget.usdSellingPrice;

    priceType = '';

    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
        if (activeTabIndex == 0) {
          priceType = 'Receive $coinName';
        } else {
          priceType = 'Receive $coinName';
        }
      });
    });

    hideScanner = false;
    title = 'Receive';

    walletAddress = '3FZbgi29cpjq2GjdwV8eyHuJJnKLtktZc5';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (hideScanner) {
            //Navigator.pop(context, false);
            setState(() {
              hideScanner = false;
            });
          } else {
            hideScanner = false;
            Navigator.pop(context, true);
          }
        },
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConstants.primaryColor,
            appBar: TopBar(
              backgroundColorStart: ColorConstants.primaryColor,
              backgroundColorEnd: ColorConstants.secondaryColor,
              title: coinName + ' Exchange',
              icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            body: Stack(children: [
              Container(
                height: 1200,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Container(
                              width: 165,
                              decoration: activeTabIndex == 0
                                  ? BoxDecoration(
                                      gradient: ColorConstants.primaryGradient,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )
                                  : BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: ColorConstants.secondaryColor,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                    ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                child: Center(
                                    child: Text('Receive $coinName',
                                        style: TextStyle(
                                            color: (activeTabIndex == 0)
                                                ? ColorConstants.white
                                                : ColorConstants
                                                    .whiteLighterColor,
                                            fontSize: 14))),
                              )),
                        ),
                        Tab(
                          child: Container(
                              width: 165,
                              decoration: activeTabIndex == 1
                                  ? BoxDecoration(
                                      gradient: ColorConstants.primaryGradient,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )
                                  : BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: ColorConstants.secondaryColor,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                    ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                child: Center(
                                    child: Text('Send $coinName',
                                        style: TextStyle(
                                            color: (activeTabIndex == 1)
                                                ? ColorConstants.white
                                                : ColorConstants
                                                    .whiteLighterColor,
                                            fontSize: 14))),
                              )),
                        ),
                      ],
                      controller: _tabController,
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            SingleChildScrollView(child: ReceiveSlide()),
                            _sendSlide(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }

  Widget ReceiveSlide() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          height: 1000,
          color: ColorConstants.primaryColor,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
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
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 16)),
                      ],
                    ),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          buildShowBottomSheet(
                            context: context,
                            bottomsheetContent: _bottomSheetContent(context),
                          );
                        },
                        child: Container(
                          child: Card(
                              color: ColorConstants.primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Choose another coin',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              )),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Column(
              children: [
                Container(
                    height: 340,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        color: ColorConstants.primaryLighterColor,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Image.asset(
                              defaultCoinImage,
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Digital Cash',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19),
                            ),
                            SizedBox(height: 5),
                            Text(
                              defaultCoinSubTitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '1 $defaultCoinSubTitle = ' +
                                  formatter
                                      .format(int.tryParse(defaultBuyingPrice)),
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '1 $defaultCoinSubTitle = ' +
                                  formatter.format(
                                      int.tryParse(defaultSellingPrice)) +
                                  'NGN',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'PRICES',
                                  style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Buy ',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          (int.tryParse(defaultusdBuyingPrice)
                                                  is int)
                                              ? 'USD ' +
                                                  formatter.format(int.tryParse(
                                                      defaultusdBuyingPrice))
                                              : 'USD ' + defaultusdBuyingPrice,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .whiteLighterColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'NGN ' +
                                              formatter.format(int.tryParse(
                                                  defaultBuyingPrice)),
                                          style: TextStyle(
                                              color: ColorConstants.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Sell ',
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          (int.tryParse(defaultusdSellingPrice)
                                                  is int)
                                              ? 'USD ' +
                                                  formatter.format(int.tryParse(
                                                      defaultusdSellingPrice))
                                              : 'USD ' + defaultusdSellingPrice,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .whiteLighterColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'NGN ' +
                                              formatter.format(int.tryParse(
                                                  defaultSellingPrice)),
                                          style: TextStyle(
                                              color: ColorConstants.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        )))
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Card(
                  color: ColorConstants.primaryLighterColor,
                  child: _buildReceiveBtc(
                      context, 'hfhjgfdbshjvbasdhvSHDVKHASVC')),
            )
          ])),
    );
  }

  Widget _sendSlide() {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 20),
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Recipient Address',
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 14)),
                    SizedBox(height: 5),
                    NormalFields(
                      hintText: 'Input BTC address',
                      labelText: 'Input BTC address',
                      controller: btcAddressController,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (email) {},
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _scanQR();
                            },
                            child: Text(
                              "Scan QR",
                              style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              getClipBoardData().then((value) =>
                                  {btcAddressController.text = value});
                            },
                            child: Text(
                              "Paste address",
                              style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    NormalFields(
                      hintText: 'Amount of BTC',
                      labelText: '',
                      controller: TextEditingController(text: ''),
                      onChanged: (name) {},
                    ),
                    SizedBox(height: 10),
                    NormalFields(
                      hintText: 'Amount in NGN',
                      labelText: '',
                      controller: TextEditingController(text: ''),
                      onChanged: (name) {},
                    ),
                    SizedBox(height: 10),
                    NormalFields(
                      hintText: 'Network Fee',
                      labelText: '',
                      controller: TextEditingController(text: ''),
                      onChanged: (name) {},
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      margin: 0,
                      disableButton: true,
                      text: 'Continue',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
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
          buttomSheetTitle: 'Select Coin',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildCoinList(),
        ]),
      ],
    );
  }

  Widget _buildCoinList() {
    return FutureBuilder(
      future: HttpService.getCoinLists(context, userId),
      builder:
          (BuildContext context, AsyncSnapshot<ListCoinsDetails> snapshot) {
        if (snapshot.hasData) {
          ListCoinsDetails listCoinsDetails = snapshot.data;
          return ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return buildListTile(
                    image: providerImages[i].image,
                    title: listCoinsDetails.data[i].coin.toUpperCase(),
                    subtitle: providerImages[i].subtitle,
                    rise: '',
                    nairaPrice: providerImages[i].nairaPrice,
                    coinPrice: providerImages[i].coinPrice,
                    onTapped: () {
                      kbackBtn(context);
                      setState(() {
                        defaultCoinImage = providerImages[i].image;
                        defaultCoinTitle = providerImages[i].title;
                        defaultCoinSubTitle = providerImages[i].subtitle;
                        defaultUSDRate =
                            listCoinsDetails.data[i].usdBuyingPrice.toString();
                        defaultBuyingPrice =
                            listCoinsDetails.data[i].buyingPrice.toString();
                        defaultSellingPrice =
                            listCoinsDetails.data[i].sellingPrice.toString();
                        defaultusdBuyingPrice =
                            listCoinsDetails.data[i].usdBuyingPrice.toString();
                        defaultusdSellingPrice =
                            listCoinsDetails.data[i].usdSellingPrice.toString();
                      });
                    });
              });
        } else if (snapshot.hasError) {
          return Center(
              child: Text('unable to load check internet',
                  style: TextStyle(color: Colors.white)));
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
          ));
        }
      },
    );
  }

  Widget buildListTile(
      {String title,
      String subtitle,
      String rise,
      String nairaPrice,
      String coinPrice,
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
            decoration: BoxDecoration(),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(image, width: 35, height: 35),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('$title',
                                style: TextStyle(
                                    color: ColorConstants.whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$nairaPrice',
                                    style: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text('$coinPrice',
                                    style: TextStyle(
                                        color: ColorConstants.whiteLighterColor,
                                        fontSize: 12)),
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
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.7),
          height: 0.5,
        ),
      ],
    );
  }

  _buildReceiveBtc(BuildContext context, String walletAd) {
    return Container(
      height: 490,
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Balance:',
                  style: TextStyle(
                      color: ColorConstants.whiteLighterColor, fontSize: 16)),
              Text('USD 0.00',
                  style: TextStyle(
                      color: ColorConstants.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0.0000000 BTC',
                  style: TextStyle(
                      color: ColorConstants.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Text('NGN 0.00',
                  style: TextStyle(
                      color: ColorConstants.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Card(
          color: ColorConstants.whiteColor,
          child: QrImage(
            data: walletAd,
            version: QrVersions.auto,
            size: 200,
            gapless: true,
            embeddedImage: AssetImage('assets/images/mbl1.jpg'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(60, 60),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text('Waiting for payment...',
            style: TextStyle(
                color: ColorConstants.whiteLighterColor, fontSize: 14)),
        SizedBox(height: 10),
        Card(
          color: ColorConstants.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(walletAd,
                style:
                    TextStyle(color: ColorConstants.whiteColor, fontSize: 14)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: new Tooltip(
                    preferBelow: false,
                    message: "Copy",
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: ColorConstants.secondaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4))),
                      child: Center(
                        child: Text('Copy',
                            style: TextStyle(
                                color: ColorConstants.white, fontSize: 14)),
                      ),
                    ),
                  ),
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: walletAd));
                    ShowSnackBar.showInSnackBar(
                        value: 'Copied! ' + walletAddress,
                        iconData: Icons.check_circle,
                        context: context,
                        scaffoldKey: _scaffoldKey,
                        timer: 5,
                        bgColor: Colors.green);
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      _onShareData(context, walletAddress, 'Share Address'),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: ColorConstants.secondaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4))),
                    child: Center(
                      child: Text('Share',
                          style: TextStyle(
                              color: ColorConstants.white, fontSize: 14)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  _onShareData(BuildContext context, String text, String subject) async {
    final RenderBox box = context.findRenderObject();
    {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Future<String> getClipBoardData() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    return data.text;
  }

  void showInfDialog(double height, Widget widgets, {String title = 'Info'}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)), //this right here
            child: Stack(
              children: [
                Container(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widgets,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildTransferBtc(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 20),
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Recipient Address',
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 14)),
                    SizedBox(height: 5),
                    NormalFields(
                      hintText: 'Input BTC address',
                      labelText: 'Input BTC address',
                      controller: btcAddressController,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (email) {},
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _scanQR();
                              });
                            },
                            child: Text(
                              "Scan QR",
                              style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              getClipBoardData().then((value) =>
                                  {btcAddressController.text = value});
                            },
                            child: Text(
                              "Paste address",
                              style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    NormalFields(
                      hintText: 'BTC amount',
                      labelText: '',
                      controller: TextEditingController(text: ''),
                      onChanged: (name) {},
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      margin: 0,
                      disableButton: true,
                      text: 'Continue',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
