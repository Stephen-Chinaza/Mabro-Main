import 'dart:convert';
import 'dart:io';
import 'package:flutter_contacts/contact.dart';
import 'package:http/http.dart' as http;

import 'package:mabro/core/models/airtime_to_cash_info.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/contact_page/contact_page.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AirtimeToCashPage extends StatefulWidget {
  final String mtnChangePin;
  final String mtnTransfer;
  final String airtelChangePin;
  final String airtelTransfer;
  final String gloChangePin;
  final String gloTransfer;
  final String mobileChangePin;
  final String mobileTransfer;
  final Contact contact;

  const AirtimeToCashPage(
      {Key key,
      this.mtnChangePin,
      this.mtnTransfer,
      this.airtelChangePin,
      this.airtelTransfer,
      this.gloChangePin,
      this.gloTransfer,
      this.mobileChangePin,
      this.mobileTransfer,
      this.contact = null})
      : super(key: key);
  @override
  _AirtimeToCashPageState createState() => _AirtimeToCashPageState();
}

class _AirtimeToCashPageState extends State<AirtimeToCashPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _pinInfo, _transferInfo;
  int _selectedIndex;
  List<ImageList> providerImages;
  bool showTransactionInfo;
  String network;
  bool showTransfer, showPin;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String email, userId;
  bool pageState;
  String text1, text2;
  IconData icon1, icon2;

  @override
  void initState() {
    super.initState();
    _transferInfo = widget.mtnTransfer;
    _pinInfo = widget.mtnChangePin;

    showTransactionInfo = false;
    pageState = false;
    network = 'mtn';
    showTransfer = false;
    showPin = false;

    _selectedIndex = 0;
    providerImages = DemoData.images;

    getData().then((value) => {
          setState(() {}),
        });

    if (widget.contact == null) {
      _phoneController.text = '';
    } else {
      _phoneController.text = widget.contact.phones.isNotEmpty
          ? widget.contact.phones.first.number
          : '(none)';
    }
  }

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    email = (pref.getString('email') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return (pageState)
        ? loadingPage(state: pageState)
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConstants.primaryColor,
            appBar: TopBar(
              backgroundColorStart: ColorConstants.primaryColor,
              backgroundColorEnd: ColorConstants.secondaryColor,
              title: 'Airtime to Cash',
              icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    _topInfoContainer(),
                    SizedBox(height: 10),
                    _middleInfoContainer(),
                    SizedBox(height: 10),
                    // BottomInfoContainer(),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextStyles.textDetails(
                        textSize: 16,
                        textColor: ColorConstants.secondaryColor,
                        textValue:
                            'only click on continue after you have transferred airtime ' +
                                'to the above number within 6 mins otherwise click cancel',
                      ),
                    ),
                    SizedBox(height: 20),

                    _bottomButton(),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: TextButton(
                  onPressed: () {
                    kbackBtn(context);
                  },
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
                text: 'Continue',
                margin: 0,
                width: 140,
                onPressed: () {
                  _submitInfo();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _middleInfoContainer() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
            color: ColorConstants.primaryLighterColor,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      copyPhone('08108803488',
                          "please do not save or call this number transfer airtime to the above number."),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            //padding: EdgeInsets.only(left: 20),
                            itemCount: providerImages.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  _onSelected(i);

                                  setState(() {
                                    switch (i) {
                                      case 0:
                                        network = 'mtn';
                                        _pinInfo = widget.mtnChangePin;
                                        _transferInfo = widget.mtnTransfer;
                                        break;
                                      case 1:
                                        network = 'glo';
                                        _pinInfo = widget.gloChangePin;
                                        _transferInfo = widget.gloTransfer;
                                        break;
                                      case 2:
                                        network = 'airtel';
                                        _pinInfo = widget.airtelChangePin;
                                        _transferInfo = widget.airtelTransfer;
                                        break;
                                      case 3:
                                        network = '9mobile';
                                        _pinInfo = widget.mtnChangePin;
                                        _transferInfo = widget.mtnTransfer;
                                        break;
                                      default:
                                        network = 'mtn';
                                        _pinInfo = widget.mobileChangePin;
                                        _transferInfo = widget.mobileTransfer;
                                    }
                                  });
                                },
                                child: Card(
                                    elevation: 3,
                                    color: providerImages[i].color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          border: Border.all(
                                            color: _selectedIndex != null &&
                                                    _selectedIndex == i
                                                ? Colors.deepPurpleAccent
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        height: 63,
                                        width: 75,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                              providerImages[i].image),
                                        ))),
                              );
                            }),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: NormalFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: 'Transferring from? (Phone number)',
                              labelText: '',
                              onChanged: (name) {},
                              textInputType: TextInputType.number,
                              controller: _phoneController,
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                kopenPage(
                                    context,
                                    Contacts(
                                      pageTitle: 'airtimeCash',
                                    ));
                              },
                              child: Container(
                                child: Icon(
                                  Icons.contact_phone,
                                  size: 40,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      NormalFields(
                        hintText: 'Enter amount',
                        labelText: '',
                        textInputType: TextInputType.number,
                        controller: _amountController,
                        onChanged: (String text) {},
                      ),
                      SizedBox(height: 20),
                    ]))));
  }

  Center copyPhone(String number, String phoneInfo) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextStyles.textDetails(
                    textSize: 18,
                    textColor: ColorConstants.whiteLighterColor,
                    textValue: number),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: number));

                      ShowSnackBar.showInSnackBar(
                          value: number + ' copied to clipboard',
                          context: context,
                          scaffoldKey: _scaffoldKey,
                          timer: 5);
                    },
                    child: new Tooltip(
                        preferBelow: false,
                        message: "Copy",
                        child: Icon(Icons.copy_outlined,
                            color: ColorConstants.secondaryColor))),
              ],
            ),
            SizedBox(height: 12),
            TextStyles.textDetails(
                centerText: true,
                textSize: 14,
                textValue: phoneInfo,
                textColor: ColorConstants.whiteLighterColor),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _topInfoContainer() {
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
                "How to transfer " + network + " airtime",
                style: TextStyle(
                  color: ColorConstants.whiteLighterColor,
                  fontSize: 16,
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
              child: TextStyles.textDetails(
                textSize: 16,
                textColor: ColorConstants.whiteColor,
                textValue: _transferInfo,
                centerText: true,
                lineSpacing: 1.5,
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
              child: TextStyles.textDetails(
                textSize: 16,
                textColor: ColorConstants.whiteColor,
                textValue: _pinInfo,
                centerText: true,
                lineSpacing: 1.5,
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

  void _submitInfo() async {
    String message = '';

    if (_phoneController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'please enter sender phone number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'please enter sent amount',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      try {
        cPageState(state: true);

        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['email_address'] = email;
        map['amount'] = _amountController.text;
        map['phone_number'] = _phoneController.text;
        map['network'] = network;

        var response =
            await http.post(HttpService.rootAirCashSubmit, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              value: 'The connection has timed out, please try again!',
              bgColor: ColorConstants.secondaryColor,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          return null;
        });
        if (response.statusCode == 200) {
          cPageState(state: false);

          var body = jsonDecode(response.body);

          AirtimeToCashInfo airtimeToCashInfo =
              AirtimeToCashInfo.fromJson(body);

          bool status = airtimeToCashInfo.status;
          message = airtimeToCashInfo.message;

          if (status) {
            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          } else if (!status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);

        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
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
                                image: AssetImage('assets/images/applogo.jpg')),
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
