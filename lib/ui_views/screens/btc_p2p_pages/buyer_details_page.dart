import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/textfield/textfield_with_endtext.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';


class BuyerDetailsPage extends StatefulWidget {
  final String coinType;
  final String coinSign;
  final String usdRate;
  final String sellersName;
  final String btcPrice;
  final String paymentMethod;

  const BuyerDetailsPage({Key key, this.coinType, this.coinSign, this.usdRate, this.sellersName, this.btcPrice, this.paymentMethod}) : super(key: key);
  @override
  _BuyerDetailsPageState createState() => _BuyerDetailsPageState();
}

class _BuyerDetailsPageState extends State<BuyerDetailsPage> {
  int dropDownValue = 0;

  List<String> paymentDetails;
  bool showBank;
  int index;
  TextEditingController selectWalletController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    showBank = false;
    index = 0;
    selectWalletController.text = 'Your Mabro NGN Wallet';

    paymentDetails = ['Your Mabro NGN Wallet', 'Your Personal' +widget.coinSign+'Wallet'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'Buy BTC',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 60, color:ColorConstants.primaryColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Buy '+ widget.coinType + ' cheap using NGN via Mabro Wallet in Nigeria from '+ widget.sellersName,
                  style: TextStyle(
                      color: ColorConstants.whiteLighterColor,
                      fontSize: 14)),
              ),
            ),),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: ColorConstants.primaryLighterColor,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text(
                            'Amount of ' + widget.coinSign,
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 12)),
                        SizedBox(height: 10),
                        TextFieldWithEndText(inputCurrencyType: widget.coinSign,
                            controller: TextEditingController(text: '')),
                        SizedBox(height: 10),
                        Text(
                            'Amount of NGN',
                            style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 14)),
                        SizedBox(height: 10),
                        TextFieldWithEndText(inputCurrencyType: 'NGN',
                            controller: TextEditingController(text: '0.00')),
                        SizedBox(height: 18),
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
                              controller: selectWalletController,
                            ),
                          );
                        }),

                        Visibility(
                          visible: showBank,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              NormalFields(
                                labelText: '',
                                isEditable: false,
                                hintText: 'Insert your '+ widget.coinSign + ' address here',
                                controller: TextEditingController(text: ''),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Amount Withdrawal fee ' + widget.coinSign+ '0.00005.00',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 11)),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                Divider(
                    color: ColorConstants
                        .lighterSecondaryColor),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(border:
                  Border.all(color: ColorConstants.lighterSecondaryColor, width: 1)),
                  child: Column(children: [
                    Container(child: Center(
                      child: Text(
                          'Advertisement details',
                          style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 16)),
                    ), color: ColorConstants.secondaryColor,height: 50),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Buying From:',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                          Text(
                              widget.sellersName,
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Price:',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                          Text(
                              widget.btcPrice,
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Amount limits:',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                          Text(
                              widget.btcPrice,
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Payment method:',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                          Text(
                              widget.paymentMethod,
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Location:',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                          Text(
                             'Nigeria',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Payment window:',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                          Text(
                              '15 mins',
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                        color: ColorConstants
                            .lighterSecondaryColor),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, color: ColorConstants.secondaryColor, size: 16,),
                        SizedBox(width: 12),
                        Text(
                            'Documents Verification required',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 10),
                  ]),
                ),


              ],
            ),
          ),

        ],
      )),
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
                title: paymentDetails[i],
                onTapped: () {
                  kbackBtn(context);
                  setState(() {
                    selectWalletController.text = paymentDetails[i];
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

}
