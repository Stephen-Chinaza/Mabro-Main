import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mabro/core/models/p2p_models/exchangeInfo.dart';
import 'package:mabro/core/services/repositories.dart';

import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/textfield_with_endtext.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSellingAdsPage extends StatefulWidget {
  final String coinType;
  final String coinSign;
  final String usdSellingPrice;
  final String nairaPrice;
  final String usdExchangeRate;

  const CreateSellingAdsPage(
      {Key key,
      this.coinType,
      this.coinSign,
      this.usdSellingPrice,
      this.nairaPrice,
      this.usdExchangeRate})
      : super(key: key);

  @override
  _CreateSellingAdsPageState createState() => _CreateSellingAdsPageState();
}

class _CreateSellingAdsPageState extends State<CreateSellingAdsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int activeTabIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<TextList> paymentDetails;
  List<String> banks;
  String nairaBalance = '';
  String userId = '';
  String priceType;

  var formatter = NumberFormat("#,##0.00", "en_US");

  TextEditingController paymentMethodController = new TextEditingController();
  TextEditingController _fixedPriceController = new TextEditingController();
  TextEditingController _displayPriceController = new TextEditingController();
  TextEditingController _minimumAmountController = new TextEditingController();
  TextEditingController _maxmumAmountController = new TextEditingController();
  TextEditingController _usdRateController = new TextEditingController();
  TextEditingController _dyDisplayPriceController = new TextEditingController();
  TextEditingController _dyMaximumPrice = new TextEditingController();
  TextEditingController _dyPaymentAmountController =
      new TextEditingController();
  TextEditingController _dyMaximumAmountController =
      new TextEditingController();
  TextEditingController _dyMinimumAmountController =
      new TextEditingController();
  TextEditingController _dyPaymentMethodController =
      new TextEditingController();

  bool showBank;
  int index;

  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nairaBalance = (pref.getString('nairaBalance') ?? '');
    userId = (pref.getString('userId') ?? '');

    setState(() {
      nairaBalance = formatter.format(int.tryParse(nairaBalance));
    });
  }

  @override
  void initState() {
    super.initState();
    showBank = false;
    priceType = 'fixed';
    index = 0;
    paymentMethodController.text = 'Mabro NGN Wallet';

    _fixedPriceController.text = widget.nairaPrice;
    _usdRateController.text = widget.usdExchangeRate;
    _dyMaximumPrice.text = widget.nairaPrice;
    _dyDisplayPriceController.text = widget.nairaPrice;
    _dyPaymentAmountController.text = widget.nairaPrice;
    _dyMaximumAmountController.text = widget.nairaPrice;
    _dyMinimumAmountController.text = widget.nairaPrice;

    getBalance();

    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
        if (activeTabIndex == 0) {
          priceType = 'fixed';
        } else {
          priceType = 'dynamic';
        }
      });
    });

    paymentDetails = DemoData.text;
    banks = DemoData.banks;
  }

  void dispose() {
    paymentMethodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      key: _scaffoldKey,
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'Create ' + widget.coinSign + ' Sell Ad',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: ColorConstants.primaryLighterColor,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.outlined_flag_sharp,
                      color: ColorConstants.secondaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selling price: NGN' + widget.nairaPrice,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900],
                                fontSize: 16)),
                        SizedBox(height: 5),
                        Text('Price in USD: ' + widget.usdSellingPrice,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[500],
                                fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price Type',
                      style: TextStyle(
                          color: ColorConstants.whiteColor, fontSize: 16)),
                ),
                TabBar(
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Container(
                          width: 165,
                          height: 36,
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
                                child: Text("Fixed Price",
                                    style: TextStyle(
                                        color: (activeTabIndex == 0)
                                            ? ColorConstants.white
                                            : ColorConstants.whiteLighterColor,
                                        fontSize: 14))),
                          )),
                    ),
                    Tab(
                      child: Container(
                          width: 165,
                          height: 36,
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
                                child: Text("Dynamic Price",
                                    style: TextStyle(
                                        color: (activeTabIndex == 1)
                                            ? ColorConstants.white
                                            : ColorConstants.whiteLighterColor,
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
                        FixedPriceSlide(),
                        DynamicPriceSlide()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FixedPriceSlide() {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Container(
            color: ColorConstants.primaryLighterColor,
            child: Card(
              color: ColorConstants.primaryLighterColor,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price of ' + widget.coinSign + ' (NGN)',
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16)),
                    SizedBox(height: 20),
                    Text('Fixed Price',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 5),
                    TextFieldWithEndText(
                        inputCurrencyType: 'NGN',
                        controller: _fixedPriceController,
                        onChanged: (string) {
                          setState(() {});
                        }),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(widget.coinSign + ' Display price',
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0,
                                Text(
                                    'The price has been accounted with trading fee (seller pay the fee).',
                                    style: TextStyle(
                                        color: ColorConstants.whiteLighterColor,
                                        fontSize: 14)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.whiteLighterColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN',
                      controller: _displayPriceController,
                      hintText: '0.00',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(widget.coinSign + ' Amount you will pay: ',
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0,
                                Text(
                                    'This is the ' +
                                        widget.coinType +
                                        ' current price at CoinBase ' +
                                        widget.coinSign +
                                        ' rate (37951.09). The price will fluctuate when CoinBase ' +
                                        widget.coinSign +
                                        ' rate changes.',
                                    style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 14,
                                    )));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.whiteLighterColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN',
                      controller: _fixedPriceController,
                      hintText: '0.00',
                      isEditable: false,
                    ),
                    SizedBox(height: 20),
                    Divider(color: ColorConstants.whiteLighterColor),
                    SizedBox(height: 20),
                    Text('Amount of ' + widget.coinSign,
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16)),
                    SizedBox(height: 20),
                    Text('Minimum ' + widget.coinSign,
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 16)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: widget.coinSign,
                      controller: _minimumAmountController,
                      hintText: '0.00',
                    ),
                    Text('$nairaBalance',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Maximum ' + widget.coinSign,
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0,
                                Text(
                                    'Maximum ' +
                                        widget.coinSign +
                                        ' amount in one trade',
                                    style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 14,
                                    )));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.whiteLighterColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWithEndText(
                        inputCurrencyType: widget.coinSign,
                        controller: TextEditingController(text: '20')),
                    SizedBox(height: 20),
                    Divider(color: ColorConstants.lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text('Payment details',
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16)),
                    SizedBox(height: 20),
                    Text('Payment method:',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 10),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          buildShowBottomSheet(
                            context: context,
                            bottomsheetContent: _bottomSheetContent(context),
                          );
                        },
                        child: IconFields(
                          isEditable: false,
                          hintText: '',
                          controller: paymentMethodController,
                        ),
                      );
                    }),
                    Visibility(
                      visible: showBank,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('Bank name',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 14)),
                          SizedBox(height: 10),
                          Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                buildShowBottomSheet(
                                  context: context,
                                  bottomsheetContent:
                                      _bottomSheetContent(context),
                                );
                              },
                              child: IconFields(
                                isEditable: false,
                                hintText: '',
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Payment window:',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 10),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          buildShowBottomSheet(
                            context: context,
                            bottomsheetContent: _bottomSheetContent(context),
                          );
                        },
                        child: IconFields(
                          isEditable: false,
                          hintText: '15 mins',
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    Divider(color: ColorConstants.lighterSecondaryColor),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showInfoDialog(220.0,
                            _UserAdsContainer(idColor: Colors.green[900]),
                            title: 'Preview');
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.eye,
                            size: 16,
                            color: ColorConstants.secondaryColor,
                          ),
                          SizedBox(width: 10),
                          Text('Preview',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 16)),
                          SizedBox(width: 5),
                          Text('your ad',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: CustomButton(
                                  margin: 0,
                                  height: 45,
                                  width: 160,
                                  disableButton: true,
                                  onPressed: () {
                                    kbackBtn(context);
                                  },
                                  text: 'Cancel'),
                            )),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: CustomButton(
                                margin: 0,
                                height: 45,
                                width: 160,
                                disableButton: true,
                                onPressed: () {},
                                text: 'Create new advertisement'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _bottomSheetContent(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select payment method'.toUpperCase(),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 3),
          _buildPaymentList(),
        ]),
      ],
    );
  }

  Widget _buildPaymentList() {
    return Container(
      color: ColorConstants.primaryLighterColor,
      child: ListView.builder(
          itemCount: paymentDetails.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                title: paymentDetails[i].text,
                onTapped: () {
                  kbackBtn(context);
                  setState(() {
                    paymentMethodController.text = paymentDetails[i].text;
                    if (i == 0) {
                      showBank = false;
                    } else if (i == 1) {
                      showBank = true;
                    }
                  });
                });
          }),
    );
  }

  Widget buildListTile({String title, Function onTapped}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style:
                          TextStyle(color: ColorConstants.whiteLighterColor)),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: ColorConstants.whiteLighterColor),
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

  Widget DynamicPriceSlide() {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Container(
            color: ColorConstants.primaryLighterColor,
            child: Card(
              color: ColorConstants.primaryLighterColor,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price of ' + widget.coinSign + ' (NGN)',
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 18)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('USD Rate ',
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     showInfoDialog(
                        //         120.0,
                        //         Text(
                        //             'Equivalent to 18,941,249.59 NGN/' +
                        //                 widget.coinSign,
                        //             style: TextStyle(
                        //                 color: ColorConstants.whiteLighterColor,
                        //                 fontSize: 14)));
                        //   },
                        //   child: Icon(
                        //     Icons.info,
                        //     color: ColorConstants.whiteLighterColor,
                        //     size: 22,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextFieldWithEndText(
                      inputCurrencyType: '',
                      controller: _usdRateController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text('Display price',
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0,
                                Text(
                                    'The price has been accounted with trading fee (buyer pay the fee).',
                                    style: TextStyle(
                                        color: ColorConstants.whiteLighterColor,
                                        fontSize: 14)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.whiteLighterColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN',
                      controller: _dyDisplayPriceController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Maximum Price:',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 5),
                    TextFieldWithEndText(
                        inputCurrencyType: 'NGN', controller: _dyMaximumPrice),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Amount you will pay',
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     showInfoDialog(
                        //         120.0,
                        //         Text(
                        //             'This is the ' +
                        //                 widget.coinType +
                        //                 ' current price at CoinBase ' +
                        //                 widget.coinSign +
                        //                 ' rate (37951.09). The price will fluctuate when CoinBase ' +
                        //                 widget.coinSign +
                        //                 ' rate changes.',
                        //             style: TextStyle(
                        //               color: ColorConstants.whiteLighterColor,
                        //               fontSize: 14,
                        //             )));
                        //   },
                        //   child: Icon(
                        //     Icons.info,
                        //     color: ColorConstants.whiteLighterColor,
                        //     size: 22,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN',
                      controller: _dyPaymentAmountController,
                    ),
                    // SizedBox(height: 20),
                    // Text('Reference Exchange:',
                    //     style: TextStyle(
                    //         color: ColorConstants.whiteLighterColor,
                    //         fontSize: 14)),
                    // SizedBox(height: 10),
                    // TextFieldWithEndText(
                    //     inputCurrencyType: widget.coinSign,
                    //     isEditable: false,
                    //     controller: TextEditingController(
                    //         text: 'CoinBase ' + widget.coinSign + ' 37803.91')),
                    SizedBox(height: 20),
                    Divider(color: ColorConstants.lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text('Amount of ' + widget.coinSign,
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 16)),
                    SizedBox(height: 20),
                    Text('Maximum' + widget.coinSign,
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                        inputCurrencyType: widget.coinSign,
                        controller: _dyMaximumAmountController),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Minimum ' + widget.coinSign,
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0,
                                Text(
                                    'Minimum ' +
                                        widget.coinSign +
                                        ' amount in one trade',
                                    style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 14,
                                    )));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.whiteLighterColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWithEndText(
                        inputCurrencyType: widget.coinSign,
                        controller: _dyMinimumAmountController),
                    SizedBox(height: 20),
                    Divider(color: ColorConstants.lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text('Payment details',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Text('Payment method:',
                        style: TextStyle(
                            color: ColorConstants.whiteLighterColor,
                            fontSize: 14)),
                    SizedBox(height: 10),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          buildShowBottomSheet(
                            context: context,
                            bottomsheetContent: _bottomSheetContent(context),
                          );
                        },
                        child: IconFields(
                          isEditable: false,
                          hintText: '',
                          controller: _dyPaymentMethodController,
                        ),
                      );
                    }),
                    Visibility(
                      visible: showBank,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('Bank name',
                              style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 14)),
                          SizedBox(height: 5),
                          Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                buildShowBottomSheet(
                                  context: context,
                                  bottomsheetContent:
                                      _bottomSheetContent(context),
                                );
                              },
                              child: IconFields(
                                isEditable: false,
                                hintText: '',
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20),
                    // Text('Payment window:',
                    //     style: TextStyle(
                    //         color: ColorConstants.whiteLighterColor,
                    //         fontSize: 14)),
                    // SizedBox(height: 5),
                    // Builder(builder: (context) {
                    //   return GestureDetector(
                    //     onTap: () {
                    //       buildShowBottomSheet(
                    //         context: context,
                    //         bottomsheetContent: _bottomSheetContent(context),
                    //       );
                    //     },
                    //     child: IconFields(
                    //       isEditable: false,
                    //       hintText: '15 mins',
                    //     ),
                    //   );
                    // }),
                    SizedBox(height: 20),
                    Divider(color: ColorConstants.lighterSecondaryColor),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showInfoDialog(220.0,
                            _UserAdsContainer(idColor: Colors.green[900]),
                            title: 'Preview');
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.eye,
                            size: 16,
                            color: ColorConstants.secondaryColor,
                          ),
                          SizedBox(width: 10),
                          Text('Preview',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 16)),
                          SizedBox(width: 5),
                          Text('your ad',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: CustomButton(
                                  margin: 0,
                                  height: 45,
                                  width: 160,
                                  disableButton: true,
                                  onPressed: () {
                                    kbackBtn(context);
                                  },
                                  text: 'Cancel'),
                            )),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: CustomButton(
                                margin: 0,
                                height: 45,
                                width: 160,
                                disableButton: true,
                                onPressed: () {},
                                text: 'Create new advertisement'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  void showInfoDialog(double height, Widget Widgets, {String title = 'Info'}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)), //this right here
            child: Stack(
              children: [
                Container(
                  height: height,
                  color: ColorConstants.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ColorConstants.primaryLighterColor),
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
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

  Widget _UserAdsContainer({
    Color idColor,
  }) {
    return Container(
      color: ColorConstants.transparent,
      child: Card(
        color: ColorConstants.primaryLighterColor,
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
                        style: TextStyle(color: idColor, fontSize: 16)),
                    Text(' NGN/BTC',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                  ],
                ),
                SizedBox(height: 5),
                Text('Maximum: 0.00025181 BTC',
                    style: TextStyle(
                        color: ColorConstants.whiteLighterColor, fontSize: 16)),
                SizedBox(height: 5),
                Text('Mabro Wallet',
                    style: TextStyle(
                        color: ColorConstants.whiteLighterColor, fontSize: 16)),
                SizedBox(height: 5),
                Text('Completion time: ~0s',
                    style: TextStyle(
                        color: ColorConstants.whiteLighterColor, fontSize: 16)),
                SizedBox(height: 5),
                Text('chievu',
                    style: TextStyle(
                        color: ColorConstants.whiteLighterColor, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createBuyAd(
      {String paymentMehod,
      String maxCoin,
      String minCoin,
      String displayAmount,
      String payAmount,
      String maxPrice,
      String fixedPrice}) async {
    String message;
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map['price_type'] = priceType;
      map['fixed_price'] = fixedPrice;
      map['max_price'] = maxPrice;
      map['usd_rate'] = _usdRateController.text;
      map['amount_you_pay'] = payAmount;
      map['display_amount'] = displayAmount;
      map['min_coin'] = minCoin;
      map['max_coin'] = maxCoin;
      map['payment_method '] = paymentMehod;

      var response =
          await http.post(HttpService.rootCreateBuyAdInfo, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            bgColor: ColorConstants.secondaryColor,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        P2PExchangeDetails p2pExchangeDetails =
            P2PExchangeDetails.fromJson(body);

        bool status = p2pExchangeDetails.status;
        message = p2pExchangeDetails.message;

        if (status) {
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
