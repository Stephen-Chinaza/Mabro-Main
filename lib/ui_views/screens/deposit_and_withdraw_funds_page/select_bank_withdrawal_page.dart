import 'dart:io';

import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBankWithdrawalPage extends StatefulWidget {
  @override
  _SelectBankWithdrawalPageState createState() => _SelectBankWithdrawalPageState();
}

class _SelectBankWithdrawalPageState extends State<SelectBankWithdrawalPage> {
  bool bankState;

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bankState = (pref.getBool('bank_state') ?? false);
  }

  @override
  void initState() {
    super.initState();
    getData();
    bankState = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TopBar(
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
            title: 'Account',
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: (bankState)
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 40.0),
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 2.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/mbl1.jpg',
                                          height: 40, width: 40),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      TextStyles.textSubHeadings(
                                        textSize: 16,
                                        textColor: Colors.black,
                                        textValue: 'Primary Account',
                                      ),
                                      SizedBox(
                                        width: 55,
                                      ),
                                      Icon(Icons.edit),
                                    ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.7),
                                height: 1,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/gtb.png',
                                          height: 40, width: 40),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextStyles.textDetails(
                                            textSize: 16,
                                            textColor: Colors.black,
                                            textValue: '0239326161',
                                          ),
                                          TextStyles.textDetails(
                                            textSize: 16,
                                            textColor: Colors.black,
                                            textValue: 'Agbo Stephen Chinaza',
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                )
              : AccountForm(),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AccountForm extends StatelessWidget {
  String _name;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 20),
              TextStyles.textDetails(
                textSize: 16,
                textColor: Colors.black,
                textValue: 'Account Setup ',
              ),
              SizedBox(height: 10),
              TextStyles.textDetails(
                textSize: 12,
                textColor: Colors.black38,
                textValue: 'Add bank account information and Bvn',
              ),
              SizedBox(height: 20),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Select Bank',
                labelText: 'Bank Names',
                onChanged: (name) {
                  print(name);
                  _name = name;
                },
                controller: TextEditingController(text: _name),
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Enter Account Number',
                labelText: 'Account Number',
                onChanged: (name) {
                  _name = name;
                },
                controller: TextEditingController(text: _name),
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                isEditable: false,
                hintText: 'Enter Account Name',
                labelText: 'Account Name',
                onChanged: (name) {
                  _name = name;
                },
                controller: TextEditingController(text: _name),
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Enter Bank Verification Number',
                labelText: 'Enter BVN',
                onChanged: (name) {
                  print(name);
                  _name = name;
                },
                controller: TextEditingController(text: _name),
              ),
              SizedBox(height: 20),
              TextStyles.textDetails(
                textSize: 12,
                textColor: Colors.black38,
                textValue:
                    'We are a digital bank and just like your regular bank,we need your BVN to be able to process transactios. Dial *565*0# on your mobile phone to get your bvn.',
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                margin: 0,
                  disableButton: true,
                  onPressed: () {},
                  text: 'Add Bank Account'),
            ]),
          ),
        ],
      ),
    );
  }
}
