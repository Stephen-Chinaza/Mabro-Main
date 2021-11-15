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
import 'package:mabro/ui_views/screens/phone_number_verification_pages/phone_otp_screen.dart';
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
  String userId;
  String bankCode = '';
  int textCount = 0;
  String id, btnText, accountNumber, bankName, accountName, phone;
  bool pageState;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  TextEditingController bvnController = new TextEditingController();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    accountNumber = (pref.getString('account_number') ?? '');
    phone = (pref.getString('phone_number') ?? '');
    bankName = (pref.getString('bank') ?? '');
    accountName = (pref.getString('account_name') ?? '');

    if (accountNumber == '') {
      setState(() {
        bankState = false;
      });
    } else {
      setState(() {
        bankState = true;
        bvnController.text = 'Verified';

      });
    }

    if(phone != ''){
      phoneController.text = phone;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    btnText = 'Add my bvn';
    bankState = false;
    btnState = false;
    pageState = false;
    phone = '';
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
                  title: 'Update Account',
                  icon:
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  onPressed: null,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                body:
                     _buildAccountForm(),
              ),
            ],
          );
  }

  Widget _buildAccountForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(children: [
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              color: ColorConstants.primaryLighterColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Manage Phone number',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor, fontSize: 18)),
                    SizedBox(height: 20),
                    NormalFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'Phone Number',
                      labelText: '',
                      textInputType: TextInputType.number,
                      maxLength: 11,
                      controller: phoneController,
                    ),

                    SizedBox(height: 25),
                    CustomButton(
                        margin: 0,
                        disableButton: true,
                        onPressed: () {
                          if (phoneController.text.isEmpty ) {
                            ShowSnackBar.showInSnackBar(
                                value: 'Please enter phone digit to continue',
                                context: context,
                                //scaffoldKey: _scaffoldKey,
                                timer: 5);
                          } else {
                            sendNumber();
                          }
                        },
                        text: 'Update phone number'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              color: ColorConstants.primaryLighterColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text('Verify your BVN',
                        style: TextStyle(
                            color: ColorConstants.secondaryColor, fontSize: 18)),
                    SizedBox(height: 15),
                    (accountNumber != '') ? Text('My BVN',
                        style: TextStyle(color: ColorConstants.whiteLighterColor, fontWeight: FontWeight.w400, fontSize: 16)) :
                    Container(),
                    SizedBox(height: 10),
                    NormalFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'My Bvn',
                      labelText: '',
                      isEditable: (accountNumber != '') ? false : true,
                      textInputType: TextInputType.number,
                      controller: bvnController,
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: (accountNumber == ''),
                      child: Column(
                        children: [
                          NormalFields(
                            width: MediaQuery.of(context).size.width,
                            hintText: 'Surname',
                            labelText: '',
                            textInputType: TextInputType.number,
                            controller: surnameController,
                          ),
                          SizedBox(height: 15),
                          NormalFields(
                            width: MediaQuery.of(context).size.width,
                            hintText: 'FirstName',
                            labelText: '',
                            textInputType: TextInputType.number,
                            controller: firstnameController,
                          ),
                          SizedBox(height: 25),
                          CustomButton(
                              margin: 0,
                              disableButton: true,
                              onPressed: () {
                                getAccountBvn();
                              },
                              text: btnText),
                        ],
                      ),
                    ),
                    (accountNumber != '') ? Text('$accountName',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)) :
                        Container(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ])
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
                      });
                    });
              });
        } else if (snapshot.hasError) {
          return Center(
              child: Text('unable to load check internet',
                  style: TextStyle(color: Colors.white)));
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

  Future<String> getAccountBvn() async {
    changeBtnText(value: 'Verifying bvn...');
    try {
      var map = Map<String, dynamic>();
      map['bvn'] = bvnController.text;
      map['first_name'] = bvnController.text;
      map['surname'] = bvnController.text;
      map['userId'] = userId;

      var response =
          await http.post(HttpService.rootVerifyBvn, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        changeBtnText(value: 'Add my bvn');
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
          changeBtnText(value: 'Add my bvn');
          String fName = accountVerification.data.firstName;
          String sName = accountVerification.data.surname;
          String accountName = '$fName ' + '$sName';
          btnState = true;
          return accountName;
        } else if (!status) {
          changeBtnText(value: 'Add my bvn');
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        changeBtnText(value: 'Add my bvn');

        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      changeBtnText(value: 'Add my bvn');

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
        map['userId'] = userId;
        map['account_number'] = accountNumberController.text;
        map['bank_code'] = bankCode;
        map['bank_name'] = bankNameController.text;

        var response =
            await http.post(HttpService.rootUpdateAccount, body: map, headers: {
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

            String accountName = updateBankDetails.data.accountName;

            var at = accountName.split('');
            String surname = at[0].trim();
            String firstName = at[1].trim();

            SharedPrefrences.addStringToSP(
                "account_number", accountNumberController.text);
            SharedPrefrences.addStringToSP("account_name", accountName);
            SharedPrefrences.addStringToSP(
                "bank_name", bankNameController.text);
            SharedPrefrences.addStringToSP("surname", surname);
            SharedPrefrences.addStringToSP("first_name", firstName);
            // SharedPrefrences.addStringToSP("id", id);

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

  void sendNumber() async {
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      map['phone_number'] =  phoneController.text;

      var response =
      await http.post(HttpService.rootSendPhone, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
          value: 'The connection has timed out, please try again!',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5,
        );

        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        RegisterUser verifyPhone = RegisterUser.fromJson(body);

        bool status = verifyPhone.status;
        String message = verifyPhone.message;
        if (status) {
          cPageState(state: false);

          String otp = verifyPhone.data.oTP;
          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 3);
          _redirectUser(code: otp);
        } else if (!status) {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
            value: message,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5,
          );
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
          value: 'Please check internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5,
          bgColor: Colors.green);
    }
  }

  void _redirectUser({String code}) {
    cPageState(state: false);
    Future.delayed(Duration(seconds: 2), () {
      pushPage(
          context,
          PhoneOtpScreen(
              contact: phoneController.text,
              phone: phoneController.text,
              code: code));
    });
  }

}
