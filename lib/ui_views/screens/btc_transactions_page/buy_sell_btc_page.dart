import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/textfield_with_image.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellBuyBTC extends StatefulWidget {
  final String walletType;

  const SellBuyBTC({Key key, this.walletType}) : super(key: key);
  @override
  _SellBuyBTCState createState() => _SellBuyBTCState();
}

class _SellBuyBTCState extends State<SellBuyBTC> {
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
            title: 'BUY/SELL BTC',
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Container(child: ToggleButtonBody(title: widget.walletType)),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ToggleButtonBody extends StatefulWidget {
  bool isBuy = true;
  bool isSell = false;
  final String title;

  List<String> reportList;

   ToggleButtonBody({Key key, this.title}) : super(key: key);

  @override
  _ToggleButtonBodyState createState() => _ToggleButtonBodyState();
}

class _ToggleButtonBodyState extends State<ToggleButtonBody> {
  String selectedChoice = "";
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Dims.screenWidth(context),
          height: 40,
          child: Center(
            child: ToggleButtons(
              fillColor: ColorConstants.primaryColor,
              hoverColor: ColorConstants.primaryColor,
              renderBorder: true,
              borderColor: Colors.grey.shade300,
              color: Colors.grey.shade800,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.isBuy) {
                      } else {
                        widget.isBuy = true;
                        widget.isSell = false;
                      }
                    });
                  },
                  child: Container(
                    width: Dims.screenWidth(context) * 0.49,
                    child: Center(
                        child: TextStyles.textHeadings(
                            textSize: 12, textValue: 'BUY')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.isSell) {
                      } else {
                        widget.isBuy = false;
                        widget.isSell = true;
                      }
                    });
                  },
                  child: Container(
                    width: Dims.screenWidth(context) * 0.49,
                    child: Center(
                        child: TextStyles.textHeadings(
                            textSize: 12, textValue: 'SELL')),
                  ),
                ),
              ],
              isSelected: [
                widget.isBuy,
                widget.isSell,
              ],
              onPressed: (index) {},
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        (widget.isBuy) ? buildBuyBody() : buildSellBody()
      ],
    );
  }

  Widget buildBuyBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.purple.withOpacity(0.3),
                    width: 1,
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            elevation: 0,
                            label: Text(widget.title.toUpperCase(),style: TextStyle(fontSize: 12)),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.arrow_forward, size: 28),
                          Chip(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            label: Text('BTC Wallet'.toUpperCase(),style: TextStyle(fontSize: 12)),
                            labelStyle: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(color: Colors.grey.withOpacity(0.3), height: 1.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      TextStyles.textDetails(
                        textSize: 14,
                        textColor: Colors.black,
                        textValue: 'Rate: 494.0/' + '\$${''}',
                      ),
                    ]),
              )),
          SizedBox(
            height: 40,
          ),
          TextStyles.textDetails(
            textSize: 12,
            textColor: Colors.black,
            textValue: 'Enter the amount you want to pay',
          ),
          SizedBox(
            height: 10,
          ),
          ImageFields(
            image: 'assets/images/naira.jpg',
            hintText: '',
            labelText: 'Amount in Naira',
            bgColor: Colors.green.withOpacity(0.2),
            onChanged: (name) {},
          ),
          SizedBox(
            height: 5,
          ),
          TextStyles.textDetails(
            textSize: 12,
            textColor: Colors.black38,
            textValue: '20,22098NGN available',
          ),
          Center(
            child: TextStyles.textDetails(
              textSize: 28,
              textColor: Colors.black,
              textValue: '=',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ImageFields(
            image: 'assets/images/dollar.png',
            hintText: '',
            labelText: 'Amount in USD',
            bgColor: Colors.grey.withOpacity(0.2),
            onChanged: (name) {},
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.arrow_upward, size: 24),
            Icon(Icons.arrow_downward, size: 24),
            SizedBox(
              width: 15,
            ),
            TextStyles.textDetails(
              textSize: 14,
              textColor: Colors.black,
              textValue: '200.0/' + '\$${''}',
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          TextStyles.textDetails(
            textSize: 12,
            textColor: Colors.black,
            textValue: 'BTC equivalent',
          ),
          SizedBox(
            height: 10,
          ),
          ImageFields(
            hintText: '',
            labelText: 'BTC',
            bgColor: Colors.yellow.withOpacity(0.2),
            onChanged: (name) {},
          ),
          SizedBox(
            height: 30,
          ),
          CustomButton(
            disableButton: true,
            onPressed: () {},
            text: 'Continue',
            margin: 0,
          ),
        ],
      ),
    );
  }

  Widget buildSellBody() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.purple.withOpacity(0.3),
                  width: 1,
                )),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          elevation: 0,
                          label: Text('BTC Wallet'.toUpperCase(), style: TextStyle(fontSize: 12)),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.arrow_forward, size: 28),
                        Chip(
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          label: Text(widget.title.toUpperCase(),style: TextStyle(fontSize: 12)),
                          labelStyle: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.withOpacity(0.3), height: 1.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    TextStyles.textDetails(
                      textSize: 14,
                      textColor: Colors.black,
                      textValue: 'Rate: 494.0/' + '\$${''}',
                    ),
                  ]),
            )),
        SizedBox(
          height: 40,
        ),
        TextStyles.textDetails(
          textSize: 12,
          textColor: Colors.black,
          textValue: 'Enter the amount you want to pay',
        ),
        SizedBox(
          height: 7,
        ),
        ImageFields(
          hintText: '',
          labelText: 'Amount in BTC',
          bgColor: Colors.yellow.withOpacity(0.2),
          onChanged: (name) {},
        ),
        SizedBox(
          height: 5,
        ),
        TextStyles.textDetails(
          textSize: 12,
          textColor: Colors.black38,
          textValue: '20,22098NGN available',
        ),
        Center(
          child: TextStyles.textDetails(
            textSize: 28,
            textColor: Colors.black,
            textValue: '=',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ImageFields(
          hintText: '',
          labelText: 'Amount in USD',
          bgColor: Colors.grey.withOpacity(0.2),
          onChanged: (name) {},
        ),
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.arrow_upward, size: 24),
          Icon(Icons.arrow_downward, size: 24),
          SizedBox(
            width: 15,
          ),
          TextStyles.textDetails(
            textSize: 14,
            textColor: Colors.black,
            textValue: '200.0/' + '\$${''}',
          ),
        ]),
        SizedBox(
          height: 20,
        ),
        TextStyles.textDetails(
          textSize: 12,
          textColor: Colors.black,
          textValue: 'BTC equivalent',
        ),
        SizedBox(
          height: 10,
        ),
        ImageFields(
          hintText: '',
          labelText: 'NGN',
          bgColor: Colors.green.withOpacity(0.2),
          onChanged: (name) {},
        ),
        SizedBox(
          height: 30,
        ),
        CustomButton(
          disableButton: true,
          onPressed: () {},
          text: 'Continue',
          margin: 0,
        ),
      ],
    ),
  );
}

}

