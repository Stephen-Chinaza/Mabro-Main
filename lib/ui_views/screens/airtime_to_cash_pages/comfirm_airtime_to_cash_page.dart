import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
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
              BottomBotton(
                  text1: 'Cancel',
                  text2: 'Continue',
                  icon1: Icons.close,
                  icon2: Icons.keyboard_arrow_right),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  color: Colors.black54,
                  text: 'only click on continue after you have transfered airtime ' +
                      'to the above number within 6 mins otherwise click cancel',
                  size: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBotton extends StatelessWidget {
  final String text1, text2;
  final IconData icon1, icon2;
  const BottomBotton({
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
          CustomButton(
            disableButton: true,
            text: text1,
            width: 140,
            icon: icon1,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CustomButton(
            disableButton: true,
            text: text2,
            width: 140,
            icon: icon2,
            onPressed: () {
              showCustomDialog(context, title: 'Upload Screenshoot');
            },
          ),
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
                      CustomText(
                          text: 'Please upload images that are less than 2MB',
                          size: 12,
                          color: Colors.red),
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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            CustomText(
                size: 14,
                text:
                    '* Transfer N2,000.00 worth of airtime to this phone number below'),
            SizedBox(height: 20),
            copyPhone('08108803488',
                'please do not save or call this number we dont accept VTU or recharge pin'),
            SizedBox(height: 40),
            CustomText(
                size: 14,
                text:
                    'please use displayed phone number once, as a new number will be provided for every transaction so as to avoid loss of artime'),
          ],
        ),
      )),
    );
  }

  Center copyPhone(String number, String phoneInfo) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(size: 26, text: number),
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
                        child: Icon(Icons.copy_outlined))),
              ],
            ),
            SizedBox(height: 5),
            CustomText(size: 14, text: phoneInfo),
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
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.info_outlined,
                color: Colors.red,
              ),
              title: Text("How to tranfer mtn airtime"),
              trailing: Icon((showTransfer)
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right),
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
                    textValue: 'Using USSD',
                  ),
                  SizedBox(height: 10),
                  TextStyles.textDetails(
                      textSize: 14,
                      textValue: '*600*Phone Number*Amount*PIN# \n\n'),
                  TextStyles.textDetails(
                    textColor: Colors.red,
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
                color: Colors.red,
              ),
              title: Text("How to set your pin"),
              trailing: Icon((showPin)
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right),
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
                    textColor: Colors.red,
                    textValue: 'Your default PIN is 0000 \n\n',
                  ),
                  TextStyles.textDetails(
                      textSize: 14,
                      textValue: 'You are advised to change your default pin'),
                  SizedBox(
                    height: 10,
                  ),
                  TextStyles.textDetails(
                    textSize: 14,
                    textValue: 'To change your pin.\n\n',
                  ),
                  TextStyles.textDetails(
                    textColor: Colors.red,
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
      color: Colors.grey.shade400,
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
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(
              text: 'Your order details',
              size: 14,
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
        CustomText(
          text: tag,
          size: 13,
        ),
        CustomText(
          text: value,
          size: 13,
        ),
      ],
    );
  }
}
