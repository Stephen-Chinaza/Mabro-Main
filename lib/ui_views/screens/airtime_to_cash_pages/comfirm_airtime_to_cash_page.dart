import 'dart:io';

import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/transaction_success_page.dart/transaction_sucessful_page.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/texts/text.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmTransferPage extends StatefulWidget {
  @override
  _ConfirmTransferPageState createState() => _ConfirmTransferPageState();
}

class _ConfirmTransferPageState extends State<ConfirmTransferPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        title: 'Confirm Transfer',
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TopInfoContainer(scaffoldKey: _scaffoldKey, context: context),
              SizedBox(height: 10),
              MiddleInfoContainer(),
              SizedBox(height: 10),
              BottomInfoContainer(),
              SizedBox(height: 10),
              BottomButton(
                  text1: 'Cancel',
                  text2: 'Continue',
                  icon1: Icons.close,
                  icon2: Icons.keyboard_arrow_right),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextStyles.textDetails(
                  textSize: 13,
                  textColor: ColorConstants.whiteLighterColor,
                  textValue:
                      'only click on continue after you have transfered airtime ' +
                          'to the above number within 6 mins otherwise click cancel',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String text1, text2;
  final IconData icon1, icon2;
  const BottomButton({
    Key key,
    this.text1,
    this.text2,
    this.icon1,
    this.icon2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 14),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(
                          color: ColorConstants.secondaryColor, width: 2)),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: ColorConstants.white),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: CustomButton(
                disableButton: true,
                text: text2,
                margin: 0,
                width: 140,
                onPressed: () {
                  showCustomDialog(context, title: 'Upload Screenshot');
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context,
      {@required String title,
      String okBtnText = "Submit",
      String cancelBtnText = "Cancel",
      Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (BuildContext contxt) {
          return AlertDialog(
            title: Text(title, style: TextStyle(fontSize: 14)),
            content: Builder(
              builder: (context) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/applogo.jpg')),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.close, size: 20),
                          ),
                        ],
                      ),
                      TextStyles.textDetails(
                          textSize: 14,
                          textValue:
                              'Please upload images that are less than 2MB',
                          textColor: ColorConstants.secondaryColor),
                      SizedBox(height: 20),
                      CustomButton(
                        text: 'Use Camera',
                        onPressed: () {},
                      ),
                      CustomButton(
                        text: 'Upload File',
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(okBtnText),
                onPressed: okBtnFunction,
              ),
              FlatButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(contxt))
            ],
          );
        });
  }
}

class TopInfoContainer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  const TopInfoContainer({Key key, this.scaffoldKey, this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
          color: ColorConstants.primaryLighterColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                TextStyles.textDetails(
                    textSize: 14,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue:
                        '* Transfer N2,000.00 worth of airtime to this phone number below'),
                SizedBox(height: 20),
                copyPhone('08108803488',
                    "please do not save or call this number we don't accept VTU or recharge pin"),
                SizedBox(height: 40),
                TextStyles.textDetails(
                    textSize: 14,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue:
                        'please use displayed phone number once, as a new number will be provided for every transaction so as to avoid loss of artime'),
              ],
            ),
          )),
    );
  }

  Center copyPhone(String number, String phoneInfo) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextStyles.textDetails(
                    textSize: 14,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue: number),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: number));

                      ShowSnackBar.showInSnackBar(
                          value: number + ' copied to clipboard',
                          context: context,
                          scaffoldKey: scaffoldKey,
                          timer: 5);
                    },
                    child: new Tooltip(
                        preferBelow: false,
                        message: "Copy",
                        child: Icon(Icons.copy_outlined,
                            color: ColorConstants.secondaryColor))),
              ],
            ),
            SizedBox(height: 5),
            TextStyles.textDetails(textSize: 14, textValue: phoneInfo),
          ],
        ),
      ),
    );
  }
}

class MiddleInfoContainer extends StatefulWidget {
  @override
  _MiddleInfoContainerState createState() => _MiddleInfoContainerState();
}

class _MiddleInfoContainerState extends State<MiddleInfoContainer> {
  bool showTransfer, showPin;

  @override
  void initState() {
    super.initState();
    showTransfer = false;
    showPin = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.info_outlined,
                color: ColorConstants.secondaryColor,
              ),
              title: Text(
                "How to transfer mtn airtime",
                style: TextStyle(
                  color: ColorConstants.whiteLighterColor,
                ),
              ),
              trailing: Icon(
                (showTransfer)
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: ColorConstants.whiteLighterColor,
              ),
              onTap: () {
                setState(() {
                  if (showTransfer) {
                    showTransfer = false;
                  } else {
                    showTransfer = true;
                  }
                });
              },
            ),
            Visibility(
              visible: showTransfer,
              child: Column(
                children: [
                  TextStyles.textDetails(
                    textSize: 14,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue: 'Using USSD',
                  ),
                  SizedBox(height: 10),
                  TextStyles.textDetails(
                      textSize: 14,
                      textColor: ColorConstants.whiteLighterColor,
                      textValue: '*600*Phone Number*Amount*PIN# \n\n'),
                  TextStyles.textDetails(
                    textColor: ColorConstants.whiteLighterColor,
                    textSize: 14,
                    textValue: 'Example: *600*08108803488*2000*0000#',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildDivider(),
            ListTile(
              leading: Icon(
                Icons.info_outlined,
                color: ColorConstants.secondaryColor,
              ),
              title: Text("How to set your pin",
                  style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                  )),
              trailing: Icon(
                (showPin)
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: ColorConstants.whiteLighterColor,
              ),
              onTap: () {
                setState(() {
                  if (showPin) {
                    showPin = false;
                  } else {
                    showPin = true;
                  }
                });
              },
            ),
            Visibility(
              visible: showPin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextStyles.textDetails(
                    textSize: 14,
                    textColor: ColorConstants.secondaryColor,
                    textValue: 'Your default PIN is 0000 \n\n',
                  ),
                  TextStyles.textDetails(
                      textSize: 14,
                      textColor: ColorConstants.whiteLighterColor,
                      textValue: 'You are advised to change your default pin'),
                  SizedBox(
                    height: 10,
                  ),
                  TextStyles.textDetails(
                    textSize: 14,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue: 'To change your pin.\n\n',
                  ),
                  TextStyles.textDetails(
                    textColor: ColorConstants.whiteLighterColor,
                    textSize: 14,
                    textValue: 'Dial: *600*Default PIN*New PIN*New PIN#',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Visibility textVisiblityDetails(
      String _text1, String _text2, String _text3, String _text4, bool state) {
    return Visibility(
      visible: state,
      child: TextStyles.richTexts(
          centerText: true,
          text1: _text1,
          text2: _text2,
          text3: _text3,
          text4: _text4),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: ColorConstants.whiteLighterColor,
    );
  }
}

class BottomInfoContainer extends StatelessWidget {
  const BottomInfoContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          color: ColorConstants.primaryLighterColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextStyles.textDetails(
                  textSize: 16,
                  textValue: 'Your order details',
                ),
                SizedBox(height: 20),
                orderDetails('phone', '08108803488'),
                SizedBox(height: 15),
                orderDetails('Amount Sent', '2,000'),
                SizedBox(height: 15),
                orderDetails('Amount to Recieve', '1,500'),
                SizedBox(height: 15),
                orderDetails('Transaction Date', '22/02/1995'),
              ],
            ),
          )),
    );
  }

  Row orderDetails(String tag, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextStyles.textDetails(
          textSize: 14,
          textColor: ColorConstants.whiteLighterColor,
          textValue: tag,
        ),
        TextStyles.textDetails(
          textSize: 14,
          textColor: ColorConstants.whiteLighterColor,
          textValue: value,
        ),
      ],
    );
  }
}
