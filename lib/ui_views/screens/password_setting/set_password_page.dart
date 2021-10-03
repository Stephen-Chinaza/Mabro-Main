import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/screens/password_setting/verify_password_page.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class SetPinPage extends StatefulWidget {
  @override
  _SetPinPageState createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: ColorConstants.primaryColor,
          body: PinScreen(),
        ),
      ],
    );
  }
}

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String textPin;

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: Dims.sizedBoxHeight(height: 50),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    GestureDetector(onTap: () {}, child: _buildSecurityText()),
                    SizedBox(
                      height: 25
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 40),
                          child: PinCodeTextField(

                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v.length < 4) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldHeight: 50,
                              fieldWidth: 50,
                              activeFillColor:
                              hasError ? Colors.orange : Colors.white,
                            ),
                            cursorColor: Colors.white,
                            animationDuration: Duration(milliseconds: 300),
                            textStyle: TextStyle(fontSize: 26, height: 1.6, color: ColorConstants.white),
                            backgroundColor: ColorConstants.primaryColor,
                            obscuringCharacter: '*',
                            enableActiveFill: false,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              print(v);

                              formKey.currentState.validate();
                              // conditions for validating
                              if (currentText.length != 4) {

                              } else {
                                setState(() {
                                  hasError = false;
                                  textEditingController.text = '';
                                  kopenPage(
                                      context,
                                      VerifyPinPage(
                                        textPin: v,
                                      ));
                                });
                              }
                            },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),

                  ],
                )),
          ]),
    );
  }

  Widget _buildSecurityText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Create your unique 4-digit pin!',
              style: TextStyle(
                fontSize: 25,
                  color: ColorConstants.secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Please remember this pin. It will be used to keep your account secured.',
            style: TextStyle(fontSize: 18, color: ColorConstants.whiteLighterColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
