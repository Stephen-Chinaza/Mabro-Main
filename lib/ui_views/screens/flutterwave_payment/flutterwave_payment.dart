import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';

import 'request_otp.dart';
import 'request_pin.dart';

class CardPayment extends StatefulWidget {


  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment>
     {
  final _cardFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext loadingDialogContext;

  final TextEditingController _cardNumberFieldController =
  TextEditingController();
  final TextEditingController _amountController =
  TextEditingController();
  final TextEditingController _nameController =
  TextEditingController();
  final TextEditingController _cardMonthFieldController =
  TextEditingController();
  final TextEditingController _cardYearFieldController =
  TextEditingController();
  final TextEditingController _cardCvvFieldController = TextEditingController();

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
    return  Scaffold(
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
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
                  child: Card(
                    color: ColorConstants.primaryLighterColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
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
                            controller: _nameController,
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
                            textInputType: TextInputType.text,
                            controller: _nameController,
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
                                    textInputType: TextInputType.text,
                                    controller: _nameController,
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
                                    textInputType: TextInputType.text,
                                    controller: _nameController,
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
                                  textInputType: TextInputType.text,
                                  controller: _nameController,
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
                                onPressed: () {},
                                text: 'pay'),
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

  String _validateCardField(String value) {
    return value != null && value.trim().isEmpty ? "Please fill this" : null;
  }

  void _hideKeyboard() {
    FocusScope.of(this.context).requestFocus(FocusNode());
  }

  void _showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
    this._scaffoldKey.currentState?.showSnackBar(snackBar);
  }


}