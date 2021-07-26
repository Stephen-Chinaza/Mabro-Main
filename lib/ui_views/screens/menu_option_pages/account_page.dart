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

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool bankState, btnState;
  String user;
  int textCount = 0;
  String id, btnText, accountNumber, bankName, accountName;
  bool pageState;

  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  TextEditingController bvnController = new TextEditingController();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    user = (pref.getString('user') ?? '');
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

    print(user);
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
                backgroundColor: Colors.transparent,
                appBar: TopBar(
                  backgroundColorStart: ColorConstants.primaryColor,
                  backgroundColorEnd: ColorConstants.secondaryColor,
                  title: 'Account',
                  icon:
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
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
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 16),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                TextStyles.textSubHeadings(
                                                  textSize: 16,
                                                  textColor: Colors.black,
                                                  textValue: 'Primary Account',
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    bankState = false;
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Card(
                                                      elevation: 3,
                                                      color: Colors.transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: ColorConstants
                                                              .primaryGradient,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50.0)),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Icon(
                                                            Icons.edit,
                                                            size: 22,
                                                            color:
                                                                ColorConstants
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ]),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
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
                                                  textValue: bankName,
                                                ),
                                                TextStyles.textDetails(
                                                  textSize: 16,
                                                  textColor: Colors.black,
                                                  textValue: accountNumber,
                                                ),
                                                TextStyles.textDetails(
                                                  textSize: 16,
                                                  textColor: Colors.black,
                                                  textValue: accountName,
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
                    : _buildAccountForm(),
              ),
            ],
          );
  }

  Widget _buildAccountForm() {
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
                textSize: 14,
                textColor: Colors.black38,
                textValue: 'Add bank account information and Bvn',
              ),
              SizedBox(height: 20),
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
                  if (textCount == 10) {
                    getAccountName().then((value) => {
                          setState(() {
                            accountNameController.text = value;
                          })
                        });
                  }
                },
                controller: accountNumberController,
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                isEditable: false,
                hintText: 'Enter account name',
                labelText: '',
                onChanged: (name) {},
                controller: accountNameController,
              ),
              SizedBox(height: 15),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Enter bank verification number',
                labelText: 'Enter BVN',
                maxLength: 11,
                textInputType: TextInputType.number,
                onChanged: (String count) {
                  setState(() {
                    textCount = count.length;
                    if (textCount == 11) {
                      getAccountBvn();
                    } else {
                      btnState = false;
                    }
                  });
                },
                controller: bvnController,
              ),
              SizedBox(height: 20),
              TextStyles.textDetails(
                textSize: 14,
                textColor: Colors.black54,
                textValue:
                    'We are a digital bank and just like your regular bank,we need your BVN to be able to process transactios. Dial *565*0# on your mobile phone to get your bvn.',
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  margin: 0,
                  disableButton: btnState,
                  onPressed: () {
                    updateAccountDetails();
                  },
                  text: btnText),
            ]),
          ),
        ],
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
      future: HttpService.getBankLists(context),
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
            height: 60,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                TextStyles.textSubHeadings(
                  textSize: 14,
                  textValue: title,
                ),
              ],
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

  Future<String> getAccountName() async {
    changeBtnText(value: 'Verifying Account number...');
    try {
      var map = Map<String, dynamic>();
      map['user'] = user;
      map['bank_name'] = bankNameController.text;
      map['account_number'] = accountNumberController.text;

      var response = await http
          .post(HttpService.rootVerifyAccountNumber, body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        changeBtnText(value: 'Add bank account');
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
          changeBtnText(value: 'Add bank account');
          String user = accountVerification.data.user;
          String accountName = accountVerification.data.accountName;
          btnState = true;
          return accountName;
        } else if (!status) {
          changeBtnText(value: 'Add bank account');
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        changeBtnText(value: 'Add bank account');

        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      changeBtnText(value: 'Add bank account');

      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  void getAccountBvn() async {
    changeBtnText(value: 'Verifying bvn...');
    try {
      var map = Map<String, dynamic>();
      map['bvn'] = bvnController.text;

      var response = await http
          .post(HttpService.rootVerifyBvn, body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        changeBtnText(value: 'Add bank account');
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
          changeBtnText(value: 'Add bank account');
          String user = accountVerification.data.user;
          String accountName = accountVerification.data.accountName;
          String accountNumber = accountVerification.data.accountNumber;

          btnState = true;
        } else if (!status) {
          changeBtnText(value: 'Add bank account');
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        changeBtnText(value: 'Add bank account');

        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      changeBtnText(value: 'Add bank account');

      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  void changeBtnText({String value}) {
    setState(() {
      btnText = value;
    });
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void updateAccountDetails() async {
    if (bankNameController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select bank', context: context, timer: 5);
    } else if (accountNumberController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter account number', context: context, timer: 5);
    } else if (accountNameController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter account name', context: context, timer: 5);
    } else if (bvnController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter bvn', context: context, timer: 5);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['user'] = user;
        map['account_number'] = accountNumberController.text;
        map['bank_name'] = bankNameController.text;
        map['bvn'] = bvnController.text;

        var response = await http
            .post(HttpService.rootUpdateAccount, body: map)
            .timeout(const Duration(seconds: 15), onTimeout: () {
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
            String user = updateBankDetails.data.user;
            String id = updateBankDetails.data.id;
            String accountName = updateBankDetails.data.accountName;
            String accountNumber = updateBankDetails.data.accountNumber;
            String bankName = updateBankDetails.data.bankName;
            //String bankCode = updateBankDetails.data.bankCode;

            var at = accountName.split(' ');
            String surname = at[0].trim();
            String firstName = at[1].trim();

            SharedPrefrences.addStringToSP("account_number", accountNumber);
            SharedPrefrences.addStringToSP("account_name", accountName);
            SharedPrefrences.addStringToSP("bank_name", bankName);
            SharedPrefrences.addStringToSP("surname", surname);
            SharedPrefrences.addStringToSP("first_name", firstName);
            SharedPrefrences.addStringToSP("id", id);

            bankNameController.text = '';
            accountNameController.text = '';
            accountNumberController.text = '';
            bvnController.text = '';

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                timer: 5);

            _redirectuser();
          } else if (!status) {
            cPageState(state: false);
            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.primaryColor,
                value: message,
                context: context,
                timer: 5);
          }
        } else {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'network error',
              bgColor: ColorConstants.primaryColor,
              context: context,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
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
