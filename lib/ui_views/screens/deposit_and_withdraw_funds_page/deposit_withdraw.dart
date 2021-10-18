import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/models/withdrawal_data.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/account_page.dart';
import 'package:mabro/ui_views/screens/select_payment_type/select_deposit_payment_type.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepositWithdrawPage extends StatefulWidget {
  final int indexNum;

  const DepositWithdrawPage({Key key, this.indexNum = 0}) : super(key: key);
  @override
  _DepositWithdrawPageState createState() => _DepositWithdrawPageState();
}

class _DepositWithdrawPageState extends State<DepositWithdrawPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  BuildContext mcontext;
  bool showCharges, isAccountSet;
  int chargeAmount;
  String userPin, userId;
  bool pageState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController withdrawAmountController = TextEditingController();
  TextEditingController withdrawMethodController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  String accountName, accountNumber, bankName, nairaBalance;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this,initialIndex: widget.indexNum);
    super.initState();

    showCharges = false;
    isAccountSet = false;
    chargeAmount = 100;

    accountName = '';
    accountNumber = '';
    bankName = '';
    nairaBalance = '';

    getData();
    pageState = false;
    withdrawMethodController.text = 'Select withdrawal method';

  }


  var formatter = NumberFormat('#,##,000');


  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    accountName = (pref.getString('account_name') ?? '');
    accountNumber = (pref.getString('account_number') ?? '');
    bankName = (pref.getString('bank_name') ?? '');
    userId = (pref.getString('userId') ?? '');
    userPin = (pref.getString('lock_code') ?? '');
    nairaBalance = (pref.getString('nairaBalance') ?? '');

    setState(() {
      nairaBalance = formatter.format(int.tryParse(nairaBalance));

    });

    accountNameController.text = accountName;
    accountNumberController.text = accountNumber;
    bankNameController.text = bankName;

    if (accountNumber == '') {
      setState(() {
        isAccountSet = false;
      });
    } else {
      setState(() {
        isAccountSet = true;
      });
    }
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
          key: _scaffoldKey,
          backgroundColor: ColorConstants.primaryColor,
          appBar: new AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: ColorConstants.primaryLighterColor,
              ),
            ),
            title: new Text("", style: TextStyle(fontSize: 18)),
            leading: GestureDetector(
                onTap: () {
                  kbackBtn(context);
                },
                child: Icon(
                  Platform.isIOS
                      ? Icons.arrow_back_ios
                      : Icons.arrow_back,
                  color: Colors.white,
                  size: 27,
                )),
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(fontSize: 14),
              labelStyle: TextStyle(fontSize: 14),
              labelColor: ColorConstants.whiteLighterColor,
              tabs: [
                new Tab(text: 'Deposit funds'),
                new Tab(
                  text: 'Withdraw funds',
                ),
              ],
              controller: _tabController,
              indicatorColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 50),
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 1,
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(child: _depositeFund()),
              SingleChildScrollView(child: _withdrawFund()),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }

  Widget _depositeFund() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Card(
          color: ColorConstants.primaryLighterColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How much do you want to deposit?',
                    style: TextStyle(
                        color: ColorConstants.secondaryColor, fontSize: 18)),
                SizedBox(height: 20),
                NormalFields(
                  width: MediaQuery.of(context).size.width,
                  hintText: 'NGN',
                  labelText: '',
                  textInputType: TextInputType.number,
                  controller: amountController,
                ),
                SizedBox(height: 5),
                Text('Balance: NGN$nairaBalance',
                    style: TextStyle(color: ColorConstants.whiteLighterColor, fontSize: 14)),
                SizedBox(height: 30),
                CustomButton(
                    margin: 0,
                    disableButton: true,
                    onPressed: () {
                      if (amountController.text.isEmpty) {
                        ShowSnackBar.showInSnackBar(
                            value: 'Please enter amount to continue',
                            context: context,
                            scaffoldKey: _scaffoldKey,
                            timer: 5);
                      } else {
                        showInfoDialog(
                          250,
                          popUpBody(),
                          title: 'Order Summary'.toUpperCase(),
                        );
                      }
                    },
                    text: 'Proceed with deposit'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget popUpBody() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Deposit Amount',
                style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14,
                    )),
            Text('NGN ' + amountController.text,
                style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14,
                    )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Processing fee',
                style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14,
                    )),
            Text('NGN 0.00',
                style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14,
                    )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text('NGN ' + amountController.text,
            style: TextStyle(
                color: ColorConstants.whiteLighterColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _withdrawFund() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Card(
          color: ColorConstants.primaryLighterColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request a withdrawal',
                    style: TextStyle(
                        color: ColorConstants.secondaryColor, fontSize: 18)),
                SizedBox(height: 20),
                Text(
                    'You can withdraw funds only to the card or wallet that was used to credit funds to your balance',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.whiteLighterColor,
                    )),
                SizedBox(height: 16),
                NormalFields(
                  width: MediaQuery.of(context).size.width,
                  hintText: 'Amount',
                  labelText: '',
                  textInputType: TextInputType.number,
                  onChanged: (name) {},
                  controller: withdrawAmountController,
                ),
                SizedBox(height: 15),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      buildShowBottomSheet(
                        context: context,
                        bottomsheetContent: _bottomSheetContentMobileCarrier(
                          context,
                          'Bank Account',
                        ),
                      );
                    },
                    child: IconFields(
                        hintText: 'Bank Account',
                        isEditable: false,
                        labelText: 'Bank Account ',
                        controller: withdrawMethodController),
                  );
                }),
                SizedBox(height: 15),
                NormalFields(
                    isEditable: false,
                    width: MediaQuery.of(context).size.width,
                    hintText: 'Bank name',
                    labelText: '',
                    onChanged: (name) {},
                    controller: bankNameController),
                SizedBox(height: 15),
                NormalFields(
                    isEditable: false,
                    width: MediaQuery.of(context).size.width,
                    hintText: 'Account name',
                    labelText: '',
                    onChanged: (name) {},
                    controller: accountNameController),
                SizedBox(height: 15),
                NormalFields(
                  isEditable: false,
                  width: MediaQuery.of(context).size.width,
                  hintText: 'Account number',
                  labelText: '',
                  controller: accountNumberController,
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    kopenPage(context, AccountPage());
                  },
                  child: Text('Edit account details',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.secondaryColor,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                Divider(color: ColorConstants.whiteLighterColor,height: 0),
                SizedBox(height: 8),
                PasswordTextField(
                  icon: Icons.lock,
                  textHint: 'Enter pin',
                  controller: pinController,
                  textInputType: TextInputType.number,
                  labelText: '',
                ),
                SizedBox(height: 30),
                CustomButton(
                    disableButton: isAccountSet,
                    onPressed: () {
                      withdrawFund();
                    },
                    text: 'Withdraw fund',
                    margin: 0),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInfoDialog(double height, Widget Widgets, {String title = 'Info'}) {
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
                                        size: 28,
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
                                kopenPage(
                                    context,
                                    SelectDepositPaymentTypePage(
                                        amount: int.parse(amountController.text)));
                              },
                              text: 'Proceed'),
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

  Widget _bottomSheetContentMobileCarrier(
      BuildContext context,
      String title,
      ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Withdrawal Method',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildCarrierList(
            context,
          ),
        ]),
      ],
    );
  }

  Widget _buildCarrierList(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                title: 'Bank Account',
                onTapped: () {
                  setState(() {
                    kbackBtn(context);
                    withdrawMethodController.text = 'Bank Account';
                  });
                });
          }),
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
                TextStyles.textDetails(
                  textSize: 16,
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

  void withdrawFund() async {
    if (withdrawAmountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter amount to withdraw',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (pinController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter transaction pin',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (userPin != pinController.text) {
      ShowSnackBar.showInSnackBar(
          value: 'Invalid pin entered',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['amount'] = withdrawAmountController.text;

        var response = await http
            .post(HttpService.rootWithdrawFund, body: map)
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

          WithdrawalData withdrawalData = WithdrawalData.fromJson(body);

          bool status = withdrawalData.status;
          String message = withdrawalData.message;
          if (status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            redirectPage();
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

  void redirectPage() {
    Future.delayed(Duration(seconds: 5), () {
      kopenPage(context, LandingPage());
    });
  }
}
