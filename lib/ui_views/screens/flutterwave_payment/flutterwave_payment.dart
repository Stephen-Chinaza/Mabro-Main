import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/opt_verification.dart';
import 'package:mabro/core/models/verify_smartcard.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';


class CardPayment extends StatefulWidget {
  final int amount;

  const CardPayment({Key key, this.amount}) : super(key: key);

  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment>

     {
  final _cardFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext loadingDialogContext;
  String userId, nairaBalance,email;
  bool pageState;
  String apiReference,apiId,reference;


  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    email = (pref.getString('email_address') ?? '');
    //userPin = (pref.getString('lock_code') ?? '');
    nairaBalance = (pref.getString('nairaBalance') ?? '');

  }

  final TextEditingController _cardPinFieldController =
  TextEditingController();
  final TextEditingController _cardNumberFieldController =
  TextEditingController();
  final TextEditingController _emailController =
  TextEditingController();
  final TextEditingController _cardOtpFieldController =
  TextEditingController();
  final TextEditingController _nameController =
  TextEditingController();
  final TextEditingController _cardMonthFieldController =
  TextEditingController();
  final TextEditingController _cardYearFieldController =
  TextEditingController();
  final TextEditingController _cardCvvFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pageState = false;

    getData().whenComplete(() => {
    setState(() {}),
      _emailController.text = email,
    });

    _nameController.text = 'Raphito';
    _cardNumberFieldController.text = '5531886652142950';
    _cardMonthFieldController.text = '09';
    _cardYearFieldController.text = '32';
    _cardCvvFieldController.text = '564';
    _cardPinFieldController.text = '3310';
    _cardOtpFieldController.text = '12345';


  }


  @override
  void dispose() {
    super.dispose();
    this._cardMonthFieldController.dispose();
    this._cardYearFieldController.dispose();
    this._cardCvvFieldController.dispose();
    this._cardNumberFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (pageState)
    ? loadingPage(state: pageState)
        : Scaffold(
        key: this._scaffoldKey,
        backgroundColor: ColorConstants.primaryColor,
        appBar: TopBar(
          backgroundColorStart: ColorConstants.primaryColor,
          backgroundColorEnd: ColorConstants.secondaryColor,
          icon:
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          title: 'Card Payment',
          onPressed: null,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Card(
                    color: ColorConstants.primaryLighterColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                        color: ColorConstants.primaryLighterColor,
                                        height: 45,width: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset('assets/images/flutterwave.png', height: 40,width: 40,),
                                        ))),
                                Row(children: [
                                  Icon(Icons.lock, color: ColorConstants.whiteLighterColor, size: 18,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Secured by flutterwave.",
                                    style: TextStyle(
                                        color: Colors.yellow[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],)
                              ],),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Enter your card details to pay.",
                              style: TextStyle(
                                  color: ColorConstants.whiteLighterColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),

                          NormalFields(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            hintText: 'Name on Card',
                            labelText: '',
                            onChanged: (name) {},
                            textInputType: TextInputType.text,
                            controller: _nameController,
                          ),
                          SizedBox(height: 20),
                          NormalFields(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            hintText: 'Your Email Address',
                            labelText: '',
                            isEditable: false,
                            onChanged: (name) {},
                            textInputType: TextInputType.text,
                            controller: _emailController,
                          ),
                          SizedBox(height: 20),
                          NormalFields(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            hintText: 'Card Number',
                            labelText: '',
                            isEditable: false,
                            onChanged: (name) {},
                            textInputType: TextInputType.number,
                            controller: _cardNumberFieldController,
                          ),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: NormalFields(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    hintText: 'Exp. Month',
                                    hintSize: 13,

                                    labelText: '',
                                    isEditable: true,
                                    onChanged: (name) {},
                                    textInputType: TextInputType.number,
                                    controller: _cardMonthFieldController,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: NormalFields(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    hintText: 'Exp. Year',
                                    hintSize: 13,
                                    labelText: '',
                                    isEditable: true,
                                    onChanged: (name) {},
                                    textInputType: TextInputType.number,
                                    controller: _cardYearFieldController,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: NormalFields(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  hintSize: 13,
                                  hintText: 'CVV',
                                  labelText: '',
                                  isEditable: true,
                                  onChanged: (name) {},
                                  textInputType: TextInputType.number,
                                  controller: _cardCvvFieldController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(
                              color: ColorConstants.whiteLighterColor
                          ),

                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                                margin: 0,
                                height: 40,
                                disableButton: true,
                                onPressed: () {
                                  showInfoDialog( height:250,Widgets: popUpPinBody(),call: 'vPayment', title: 'Enter card pin', );
                                },
                                text: 'Pay NGN'+ widget.amount.toString()),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _onCardFormClick() {
    this._hideKeyboard();
    if (this._cardFormKey.currentState.validate()) {

    }
  }

  void _makeCardPayment() {
    Navigator.of(this.context).pop();


  }
  
  void _hideKeyboard() {
    FocusScope.of(this.context).requestFocus(FocusNode());
  }


  void verifyPayment() async {
      if (_nameController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter cardholders name',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (_emailController.text.isEmpty) {
        ShowSnackBar.showInSnackBar(
            value: 'Enter email address',
            context: context,
            scaffoldKey: _scaffoldKey);
      } else if (_cardNumberFieldController.text.isEmpty) {
        ShowSnackBar.showInSnackBar(
            value: 'Enter card number',
            context: context,
            scaffoldKey: _scaffoldKey);

    } else if (_cardMonthFieldController.text.isEmpty) {
        ShowSnackBar.showInSnackBar(
            value: 'Enter expiration month',
            context: context,
            scaffoldKey: _scaffoldKey);

      }else if (_cardYearFieldController.text.isEmpty) {
        ShowSnackBar.showInSnackBar(
            value: 'Enter expiration year',
            context: context,
            scaffoldKey: _scaffoldKey);

      }else if (_cardCvvFieldController.text.isEmpty) {
        ShowSnackBar.showInSnackBar(
            value: 'Enter card cvv number',
            context: context,
            scaffoldKey: _scaffoldKey);

      }
      else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['name'] = _nameController.text;
        map['email_address'] = email;
        map['card_number'] = _cardNumberFieldController.text;
        map['cvv'] = _cardCvvFieldController.text;
        map['exp_month'] = _cardMonthFieldController.text;
        map['exp_year'] = _cardYearFieldController.text;
        map['pin'] = _cardPinFieldController.text;
        map['amount'] = widget.amount.toString();

        print(userId);
        print(_nameController.text);
        print(email);
        print(_cardNumberFieldController.text);
        print(_cardCvvFieldController.text);
        print(_cardMonthFieldController.text);
        print(_cardYearFieldController.text);
        print(_cardPinFieldController.text);
        print(widget.amount);

        var response = await http
            .post(HttpService.rootVerifyCardPayment, body: map, headers: {
          'Authorization': 'Bearer '+HttpService.token,
        })
            .timeout(const Duration(seconds: 30), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'The connection has timed out, please try again!',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          VerifySmartcard verifySmartcard = VerifySmartcard.fromJson(body);

          bool status = verifySmartcard.status;
          String message = verifySmartcard.message;
          if (status) {
            cPageState(state: false);

            String authMode = verifySmartcard.data.authMode;
             apiReference = verifySmartcard.data.apiReference;
            apiId = verifySmartcard.data.apiId.toString();
            reference = verifySmartcard.data.reference;

            if(authMode == 'otp'){
              showInfoDialog(height: 250,Widgets:  popUpOtpBody(),title: 'Enter OTP',call: 'otp',);

            }else if (authMode == 'redirect'){

            }
            //redirectPage();
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

  void verifyOtp() async {
    cPageState(state: false);
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map['api_reference'] = apiReference;
      map['api_id'] = apiId;
      map['otp'] = _cardOtpFieldController.text;
      map['reference'] = reference;


      var response = await http
          .post(HttpService.rootVerifyOtp, body: map, headers: {
        'Authorization': 'Bearer '+HttpService.token,
      })
          .timeout(const Duration(seconds: 15), onTimeout: () {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        OtpVerification otpVerification = OtpVerification.fromJson(body);

        bool status = otpVerification.status;
        String message = otpVerification.message;
        if (status) {
          cPageState(state: false);
          String balance = otpVerification.data.balance.toString();

          ShowSnackBar.showInSnackBar(
              value: message+ ' ' +otpVerification.data.amount.toString() + ' was added to your account',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);

          kopenPage(context, LandingPage());
          SharedPrefrences.addStringToSP("nairaBalance", balance);

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


  void showInfoDialog({double height, Widget Widgets, String call, String title = 'Info'}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Stack(
              children: [
                Container(
                  color: ColorConstants.primaryColor,
                  height: height,
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
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
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
                        Center(
                          child: CustomButton(
                              margin: 0,
                              width: 130,
                              disableButton: true,
                              onPressed: () {
                                Navigator.of(context).pop();
                                if(call == 'vPayment'){
                                  verifyPayment();

                                }else if(call == 'otp'){
                                  verifyOtp();
                                }
                              },
                              text: 'Continue'),
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

  Widget popUpPinBody() {
    return Column(
      children: [
        NormalFields(
          width: MediaQuery
              .of(context)
              .size
              .width,
          hintSize: 16,
          hintText: 'Enter card pin',
          labelText: '',
          isEditable: true,
          onChanged: (name) {},
          textInputType: TextInputType.number,
          controller: _cardPinFieldController,
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget popUpOtpBody() {
    return Column(
      children: [
        NormalFields(
          width: MediaQuery
              .of(context)
              .size
              .width,
          hintSize: 13,
          hintText: 'Enter Otp',
          labelText: '',
          isEditable: true,
          onChanged: (name) {},
          textInputType: TextInputType.text,
          controller: _cardOtpFieldController,
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

}