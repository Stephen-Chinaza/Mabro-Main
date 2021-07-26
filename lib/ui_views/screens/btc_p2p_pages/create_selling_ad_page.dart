import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/textfield/textfield_with_endtext.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';




class CreateSellingAdsPage extends StatefulWidget {
  final String coinType;
  final String coinSign;
  final String usdRate;

  const CreateSellingAdsPage({Key key, this.coinType, this.coinSign, this.usdRate}) : super(key: key);

  @override
  _CreateSellingAdsPageState createState() => _CreateSellingAdsPageState();
}

class _CreateSellingAdsPageState extends State<CreateSellingAdsPage>  with SingleTickerProviderStateMixin {
  TabController _tabController;
  int activeTabIndex = 0;

  List<TextList> paymentDetails;
  List<String> banks;

  TextEditingController paymentMethodController = new TextEditingController();

  bool showBank;
  int index;

  @override
  void initState() {
    super.initState();
    showBank = false;
    index = 0;
    paymentMethodController.text = 'Mabro NGN Wallet';

    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
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
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'Ad to sell ' + widget.coinType,
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(

        child: Container(
          height: size.height,
          child: Column(
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
                  Text('Market sell price: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                          fontSize: 16)),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: '19,130,662.08 ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primaryColor,
                                fontSize: 14)),
                        TextSpan(
                            text: 'NGN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.secondaryColor,
                                fontSize: 14)),
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TabBar(
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Container(
                        width: 100,
                        height: 36,
                        decoration: activeTabIndex == 0
                            ? BoxDecoration(
                          border: Border.all(
                              color: ColorConstants.white, width: 2),
                          gradient: ColorConstants.primaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )
                            : null,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                          child: Center(child: Text("Fixed Price",
                              style: TextStyle(color: (activeTabIndex == 0)
                                  ? ColorConstants.white
                                  : ColorConstants.secondaryColor,
                                  fontSize: 12))),
                        )),
                  ),
                  Tab(
                    child: Container(
                        width: 120,
                        height: 36,
                        decoration: activeTabIndex == 1
                            ? BoxDecoration(
                          border: Border.all(
                              color: ColorConstants.white, width: 2),
                          gradient: ColorConstants.primaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )
                            : null,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                          child: Center(child: Text("Dynamic Price",
                              style: TextStyle(color: (activeTabIndex == 1)
                                  ? ColorConstants.white
                                  : ColorConstants.secondaryColor,
                                  fontSize: 12))),
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
    );
  }

  Widget FixedPriceSlide() {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Text(
                        'Fixed Price',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(inputCurrencyType: 'NGN',),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                            widget.coinSign + ' price that buyers see: ',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                 120.0, Text(
                                'The price has been accounted with trading fee (buyer pay the fee).',
                                style: TextStyle(color: ColorConstants.secondaryColor,
                                    fontSize: 12)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN|' + widget.coinSign,
                      controller: TextEditingController(text: '0'),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                            widget.coinSign + ' price that you receive: ',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                 120.0, Text('This is the '+ widget.coinType + ' current price at CoinBase ' +
                                widget.coinSign +
                                ' rate (37951.09). The price will fluctuate when CoinBase ' +
                                widget.coinSign + ' rate changes.',
                                style: TextStyle(color: ColorConstants.secondaryColor,
                                  fontSize: 12,)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN|' + widget.coinSign,
                      controller: TextEditingController(text: '0'),),
                    SizedBox(height: 20),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text(
                        'Amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Text(
                        'Amount of ' + widget.coinSign,
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(inputCurrencyType: widget.coinSign,
                        controller: TextEditingController(text: '0.00833333')),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                            'Maximum ' + widget.coinSign + ' amount',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(120.0, Text('Maximum ' + widget.coinSign + ' amount in one trade',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12,)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWithEndText(inputCurrencyType: widget.coinSign,
                        controller: TextEditingController(text: '0.00833333')),
                    SizedBox(height: 20),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text(
                        'Payment details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Text(
                        'Payment method:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
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

                    SizedBox(height: 20),
                    Visibility(
                      visible: showBank,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                              'Bank name',
                              style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 12)),
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
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                        'Payment window:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
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
                    SizedBox(height: 20),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text(
                        'Reject unverified buyer:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
                    SizedBox(height: 10),
                    NormalFields(
                      labelText: '',
                      isEditable: false,
                      hintText: '',
                      controller: TextEditingController(text: 'Yes'),
                    ),
                    SizedBox(height: 20),
                    Row(children: [
                      Icon(FontAwesomeIcons.eye, size: 16, color: ColorConstants.secondaryColor,),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap:(){
                          showInfoDialog(
                              220.0, _UserAdsContainer(idColor: Colors.green[900]), title: 'Preview');
                        },
                        child: Text(
                            'Preview',
                            style: TextStyle(
                                color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                      ),
                      SizedBox(width: 10),
                      Text(
                          'your ad',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12)),
                    ],),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: CustomButton(
                              margin: 0,
                              height: 30,
                              width: 160,
                              disableButton: true,
                              onPressed: (){
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
                              height: 30,
                              width: 160,
                              disableButton: true,
                              onPressed: () {
                              },
                              text: 'Create new advertisement'),
                        ),
                      ),
                    ],),
                    SizedBox(height: 80),

                  ],),
              ),
            )),
      ],
    );
  }

  Widget _bottomSheetContent(BuildContext context,) {
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
                    if(i == 0){
                      showBank = false;
                    }else if(i == 1){
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
            height: 40,
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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Icon(Icons.arrow_forward_ios, size: 16,),
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
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                             'bitUSD Price: ',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0, Text(
                                'Equivalent to 18,941,249.59 NGN/'+widget.coinSign,
                                style: TextStyle(color: ColorConstants.secondaryColor,
                                    fontSize: 12)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN|' + widget.usdRate,
                      controller: TextEditingController(text: '497.4145'),),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                            widget.coinSign + ' price that buyers see: ',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0, Text(
                                'The price has been accounted with trading fee (buyer pay the fee).',
                                style: TextStyle(color: ColorConstants.secondaryColor,
                                    fontSize: 12)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN|' + widget.coinSign,
                      controller: TextEditingController(text: '19,130,662.08'),),
                    SizedBox(height: 20,),
                    Text(
                        'Maximum ' + widget.coinSign + ' price:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(inputCurrencyType: 'NGN',
                        controller: TextEditingController(text: '')),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                            widget.coinSign + ' price that you receive: ',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                120.0, Text('This is the Bitcoin price at current CoinBase ' +
                                widget.coinSign +
                                ' rate (37951.09). The price will fluctuate when CoinBase ' +
                                widget.coinSign + ' rate changes.',
                                style: TextStyle(color: ColorConstants.secondaryColor,
                                  fontSize: 12,)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithEndText(
                      inputCurrencyType: 'NGN|' + widget.coinSign,
                      controller: TextEditingController(text: '18,941,249.59'),),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Text(
                        'Reference Exchange:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(inputCurrencyType: widget.coinSign,
                        isEditable: false,
                        controller: TextEditingController(text: 'CoinBase '+ widget.coinSign + ' 37803.91')),
                    SizedBox(height: 20),

                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text(
                        'Amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Text(
                        'Amount of ' + widget.coinSign,
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
                    SizedBox(height: 10),
                    TextFieldWithEndText(inputCurrencyType: widget.coinSign,
                        controller: TextEditingController(text: '20')),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Text(
                            'Maximum ' + widget.coinSign + ' amount',
                            style: TextStyle(color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(120.0, Text('Maximum ' + widget.coinSign + ' amount in one trade',
                                style: TextStyle(color: ColorConstants.secondaryColor,
                                  fontSize: 12,)));
                          },
                          child: Icon(
                            Icons.info,
                            color: ColorConstants.lighterSecondaryColor,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWithEndText(inputCurrencyType: widget.coinSign,
                        controller: TextEditingController(text: '20')),
                    SizedBox(height: 20),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 20),
                    Text(
                        'Payment details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 16)),
                    SizedBox(height: 20),
                    Text(
                        'Payment method:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
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
                          Text(
                              'Bank name',
                              style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 12)),
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
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                        'Payment window:',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 12)),
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
                    SizedBox(height: 20),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 20),
                    Row(children: [
                      Icon(FontAwesomeIcons.eye, size: 16, color: ColorConstants.secondaryColor,),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap:(){
                          showInfoDialog(
                              220.0, _UserAdsContainer(idColor: Colors.green[900]), title: 'Preview');
                        },
                        child: Text(
                            'Preview',
                            style: TextStyle(
                                color: ColorConstants.secondaryColor,
                                fontSize: 12)),
                      ),
                      SizedBox(width: 10),
                      Text(
                          'your ad',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12)),
                    ],),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: CustomButton(
                                margin: 0,
                                height: 30,
                                width: 160,
                                disableButton: true,
                                onPressed: (){
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
                              height: 30,
                              width: 160,
                              disableButton: true,
                              onPressed: () {
                              },
                              text: 'Create new advertisement'),
                        ),
                      ),
                    ],),
                    SizedBox(height: 80),

                  ],),
              ),
            )),
      ],
    );
  }

  void showInfoDialog(double height,Widget Widgets , {String title = 'Info'}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(5.0)), //this right here
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 40,
                          child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(title,
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close, color: Colors.white,
                                      size: 20,))
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
                Text('Mabro Wallet',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.secondaryColor,
                        fontSize: 16)),
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
    );
  }
}
