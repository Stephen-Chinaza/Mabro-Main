import 'dart:convert';
import 'dart:io';

import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/add_funds.dart';
import 'package:mabro/core/models/register_user.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/screens/landing_page/landing_page.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:monnify_flutter_sdk/monnify_flutter_sdk.dart' as a;
import 'package:mabro/core/services/api_service.dart';
import 'package:mabro/res/colors.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SelectDepositPaymentTypePage extends StatefulWidget {
  final String amount;

  const SelectDepositPaymentTypePage({Key key, this.amount}) : super(key: key);
  @override
  _SelectDepositPaymentTypePageState createState() =>
      _SelectDepositPaymentTypePageState();
}

class _SelectDepositPaymentTypePageState
    extends State<SelectDepositPaymentTypePage> {
  bool _hasTransactionStarted = false;
  String email, user;
  bool pageState;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = (pref.getString('email_address') ?? '');
    user = (pref.getString('user') ?? '');
  }

  var publicKey = 'pk_test_9a1befcef6741639660d3028bb8414b2216c8f04';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    //initializing Monnify Api
    initializeSdk();
    //initializing Paystack Api
    plugin.initialize(publicKey: publicKey);
    getData();
    pageState = false;
    print(widget.amount);
  }

  //Monnify Functions
  Future<void> initializeSdk() async {
    try {
      if (await a.MonnifyFlutterSdk.initialize(
          'MK_TEST_R4AA65S34T', '4473431289', a.ApplicationMode.TEST)) {
        //_showToast("SDK initialized!");
      }
    } on PlatformException catch (e, s) {}
  } //

  Future<void> initPayment() async {
    a.TransactionResponse transactionResponse;

    try {
      transactionResponse =
          await a.MonnifyFlutterSdk.initializePayment(a.Transaction(
        double.tryParse(widget.amount),
        "NGN",
        "Customer Name",
        email,
        getRandomString(15),
        "Cash Deposit to Mabro wallet",
        metaData: {"ip": "196.168.45.22", "device": "mobile"},
        paymentMethods: [
          a.PaymentMethod.CARD,
          a.PaymentMethod.ACCOUNT_TRANSFER
        ],
      ));
      if (transactionResponse.transactionStatus.toLowerCase() == 'paid') {
        verifyPayment(
            transactionResponse.transactionReference,
            Uri.parse(
                'https://iceztech.com/mabro/fund-account/verify-monnify'));
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'Transaction failed',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on PlatformException catch (e, s) {
      print("Error initializing payment");
      print(e);
      print(s);
    }
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  //Functions for Paystack
  _startCharge() async {
    setState(() {
      _hasTransactionStarted = !_hasTransactionStarted;
    });
    var values = await APIService.initTransaction(
        'sk_test_5031aae886b430022c410efb43b64b6f3f1a764d',
        widget.amount + '00',
        'agbo.raph123@gmail.com');

    Charge _charge = Charge()
      ..email = 'agbo.raph123@gmail.com'
      ..amount = int.tryParse(widget.amount + '00')
      ..accessCode = values['data']['access_code'];

    CheckoutResponse _checkoutResponse = await plugin.checkout(
      context,
      charge: _charge,
      method: CheckoutMethod.selectable,
    );

    if (_checkoutResponse.status == true) {
      print(_checkoutResponse.reference);
      verifyPayment(_checkoutResponse.reference,
          Uri.parse('https://iceztech.com/mabro/fund-account/verify-paystack'));
    } else {}
    setState(() {
      _hasTransactionStarted = !_hasTransactionStarted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            body: (pageState)
                ? loadingPage(state: pageState)
                : (!_hasTransactionStarted)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          kbackBtn(context);
                                        },
                                        child: Icon(
                                          Platform.isIOS
                                              ? Icons.arrow_back_ios
                                              : Icons.arrow_back,
                                          size: 30,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'How would you like to add money to your Mabro wallet?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                initPayment();
                              },
                              child: Container(
                                  height: 70,
                                  color: Colors.white,
                                  child: Card(
                                    elevation: 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/images/monnify.png',
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          color: ColorConstants
                                              .lighterSecondaryColor
                                              .withOpacity(0.3),
                                          height: 70,
                                          width: 0.5,
                                        ),
                                        SizedBox(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              'Instant payment with Monnify',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                _startCharge();
                              },
                              child: Container(
                                  height: 70,
                                  child: Card(
                                    elevation: 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/images/paystack.png',
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          color: ColorConstants
                                              .lighterSecondaryColor
                                              .withOpacity(0.3),
                                          height: 70,
                                          width: 0.5,
                                        ),
                                        SizedBox(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              'Instant payment with Paystack',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        )),
                      )
                    : loadingPage(state: _hasTransactionStarted)),
      ],
    );
  }

  void verifyPayment(String paymentReference, Uri url) async {
    cPageState(state: true);
    try {
      var map = Map<String, dynamic>();
      map['user'] = user;
      map['amount'] = widget.amount;
      map['source_reference'] = paymentReference;

      var response = await http
          .post(url, body: map)
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

        AddFunds addFunds = AddFunds.fromJson(body);

        bool status = addFunds.status;
        String message = addFunds.message;
        if (status) {
          cPageState(state: false);
          String nairaBalance = addFunds.data.nairaBalance.toString();

          SharedPrefrences.addStringToSP("naria_balance", nairaBalance);
          SharedPrefrences.addStringToSP("user", user);

          ShowSnackBar.showInSnackBar(
              iconData: Icons.check_circle,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 3);
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
            bgColor: ColorConstants.primaryColor,
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      cPageState(state: false);
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }

  void redirectPage() {
    Future.delayed(Duration(seconds: 2), () {
      kopenPage(context, LandingPage());
    });
  }
}