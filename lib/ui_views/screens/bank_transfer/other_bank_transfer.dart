import 'dart:convert';
import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/models/list_bank.dart';
import 'package:mabro/core/models/posts.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/models/update_account.dart';
import 'package:mabro/core/models/verify_account_number.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class BankTransferPage extends StatefulWidget {
  @override
  _BankTransferPageState createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  bool bankState, btnState;
  String userId;
  String bankCode = '';
  int textCount = 0;
  String id, btnText, accountNumber, bankName, accountName;
  bool pageState;

  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController narrationController = new TextEditingController();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    accountNumber = (pref.getString('account_number') ?? '');
    bankName = (pref.getString('bank_name') ?? '');
    accountName = (pref.getString('account_name') ?? '');

    if (accountNumber == '') {
      setState(() {
        bankState = false;
      });
    } else {
      setState(() {
        bankState = true;
      });
    }

    print(userId);
  }

  @override
  void initState() {
    btnText = 'Add bank account';
    super.initState();
    getData();
    bankState = false;
    btnState = false;
    pageState = false;
  }

  @override
  Widget build(BuildContext context) {
    return (pageState)
        ? loadingPage(state: pageState)
        : Stack(
            children: [
              buildFirstContainer(),
              buildSecondContainer(),
              Scaffold(
                backgroundColor: ColorConstants.primaryColor,
                appBar: TopBar(
                  backgroundColorStart: ColorConstants.primaryColor,
                  backgroundColorEnd: ColorConstants.secondaryColor,
                  title: 'Bank Transfer',
                  icon:
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  onPressed: null,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                body: _buildAccountForm(),
              ),
            ],
          );
  }

  Widget _buildAccountForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Card(
            color: ColorConstants.primaryLighterColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        TextStyles.textDetails(
                          textSize: 16,
                          textColor: ColorConstants.secondaryColor,
                          textValue:
                              'Enter transactions details '.toUpperCase(),
                        ),
                        SizedBox(height: 10),
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              buildShowBottomSheet(
                                context: context,
                                bottomsheetContent:
                                    _bottomSheetContent(context),
                              );
                            },
                            child: IconFields(
                              isEditable: false,
                              hintText: 'Select bank',
                              controller: bankNameController,
                            ),
                          );
                        }),
                        SizedBox(height: 15),
                        NormalFields(
                          width: MediaQuery.of(context).size.width,
                          hintText: 'Enter account number',
                          labelText: '',
                          maxLength: 10,
                          textInputType: TextInputType.number,
                          onChanged: (String count) {
                            textCount = count.length;
                            if (textCount == 10) {}
                          },
                          controller: accountNumberController,
                        ),
                        SizedBox(height: 15),
                        NormalFields(
                          width: MediaQuery.of(context).size.width,
                          hintText: 'Enter amount',
                          labelText: '',
                          maxLength: 11,
                          textInputType: TextInputType.number,
                          onChanged: (String count) {},
                          controller: amountController,
                        ),
                        SizedBox(height: 15),
                        NormalFields(
                          width: MediaQuery.of(context).size.width,
                          isEditable: false,
                          hintText: 'narration',
                          labelText: '',
                          onChanged: (name) {},
                          controller: narrationController,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                            margin: 0,
                            disableButton: true,
                            onPressed: () {
                              verifyAccount();
                            },
                            text: 'Continue'),
                      ]),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetContent(
    BuildContext context,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BottomSheetHeader(
        buttomSheetTitle: 'Select bank'.toUpperCase(),
      ),
      SizedBox(height: 6),
      Expanded(child: _buildBankList()),
    ]);
  }

  Widget _buildBankList() {
    return FutureBuilder(
      future: HttpService.getBankLists(context, userId),
      builder: (BuildContext context, AsyncSnapshot<ListBanks> snapshot) {
        if (snapshot.hasData) {
          ListBanks banks = snapshot.data;
          return ListView.builder(
              itemCount: banks.data.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return buildListTile(
                    title: banks.data[i].name,
                    onTapped: () {
                      kbackBtn(context);
                      setState(() {
                        bankNameController.text = banks.data[i].name;
                        bankCode = banks.data[i].code;
                        print(bankCode);
                      });
                    });
              });
        } else if (snapshot.hasError) {
          return Center(child: Text('unable to load check internet'));
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
          ));
        }
      },
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
            height: 50,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                TextStyles.textDetails(
                  textSize: 14,
                  textColor: ColorConstants.whiteLighterColor,
                  textValue: title,
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: ColorConstants.whiteLighterColor,
          height: 0.5,
        ),
      ],
    );
  }

  void verifyAccount() async {
    if (bankNameController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select bank', context: context, timer: 5);
    } else if (accountNumberController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter account number', context: context, timer: 5);
    } else if (amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter amount', context: context, timer: 5);
    } else if (narrationController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter narration', context: context, timer: 5);
    } else {
      cPageState(state: true);

      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['bank_code'] = '044';

        //bankCode;
        map['account_number'] = accountNumberController.text;

        var response = await http
            .post(HttpService.rootVerifyTransfer, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'The connection has timed out, please try again!',
              context: context,
              timer: 5);
          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          AccountVerification accountVerification =
              AccountVerification.fromJson(body);

          bool status = accountVerification.status;
          String message = accountVerification.message;
          if (status) {
            cPageState(state: false);
            print(userId);
            transferFund();
          } else if (!status) {
            cPageState(state: false);
            ShowSnackBar.showInSnackBar(
                value: message, context: context, timer: 5);
          }
        } else {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              value: 'network error', context: context, timer: 5);
        }
      } on SocketException {
        cPageState(state: false);

        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            timer: 5);
      }
    }
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void transferFund() async {
    if (bankNameController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select bank', context: context, timer: 5);
    } else if (accountNumberController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter account number', context: context, timer: 5);
    } else if (amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter amount', context: context, timer: 5);
    } else if (narrationController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter narration', context: context, timer: 5);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['account_number'] = accountNumberController.text;
        map['bank_code'] = '044';

        // bankCode;
        map['amount'] = amountController.text;
        map['narration'] = narrationController.text;
        var response =
            await http.post(HttpService.rootTransferFund, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'The connection has timed out, please try again!',
              context: context,
              timer: 5);
          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          cPageState(state: false);

          UpdateBankDetails updateBankDetails =
              UpdateBankDetails.fromJson(body);

          bool status = updateBankDetails.status;
          String message = updateBankDetails.message;
          if (status) {
            cPageState(state: false);

            bankNameController.text = '';
            amountController.text = '';
            accountNumberController.text = '';
            narrationController.text = '';

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                timer: 5);

            //_redirectuser();
          } else if (!status) {
            cPageState(state: false);
            ShowSnackBar.showInSnackBar(
                value: message, context: context, timer: 5);
          }
        } else {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'network error', context: context, timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            timer: 5);
      }
    }
  }

  void _redirectuser() {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 6), () {
      pushPage(context, LandingPage());
    });
  }
}
