import 'package:mabro/core/models/login_user.dart';
import 'package:mabro/core/models/transfer_fund.dart';
import 'package:mabro/core/models/verify_transfer.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/services/repositories.dart';

import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MabroTransferPage extends StatefulWidget {
  @override
  _MabroTransferPageState createState() => _MabroTransferPageState();
}

class _MabroTransferPageState extends State<MabroTransferPage> {
  String message, vEmail, userId;
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeAmount = FocusNode();
  bool pageState;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();

  String userName = '';

  Future<void> getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');

    setState(() {});
  }

  String _email, _amount;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    myFocusNodeAmount.dispose();
    myFocusNodeEmail.dispose();
    _emailController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageState = false;
    _email = '';
    _amount = '';

    getUserDetails().then((value) => {
          setState(() {}),
        });
  }

  Widget _buildTransferForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Card(
            color: ColorConstants.primaryLighterColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
              child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provide transaction details'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      NormalFields(
                        width: MediaQuery.of(context).size.width,
                        hintText: 'Enter user email address',
                        labelText: '',
                        onChanged: (name) {},
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      NormalFields(
                        width: MediaQuery.of(context).size.width,
                        hintText: 'Enter amount to transfer',
                        labelText: '',
                        onChanged: (name) {},
                        textInputType: TextInputType.number,
                        controller: _amountController,
                      ),
                      SizedBox(
                        height: Dims.sizedBoxHeight(height: 20),
                      ),
                      CustomButton(
                          margin: 0,
                          disableButton: true,
                          onPressed: () {
                            _verifyUser();
                          },
                          text: 'Continue'),
                      SizedBox(height: 25),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock,
                                color: ColorConstants.whiteLighterColor),
                            SizedBox(width: 5),
                            Text(
                              'Transfer secured by Mabro',
                              style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w200),
                            ),
                          ])
                    ]),
              ),
            ),
          ),
        ),
        //Expanded(child: Container()),
      ],
    );
  }

  void _verifyUser() async {
    if (_emailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'Enter reciepient email',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'enter amount to transfer',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = _emailController.text;
        map['userId'] = userId;

        var response =
            await http.post(HttpService.verifyTransfer, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'The connection has timed out, please try again!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5,
          );

          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          VerifyTransfer verifyUser = VerifyTransfer.fromJson(body);

          bool status = verifyUser.status;
          String message = verifyUser.message;
          if (status) {
            cPageState(state: false);

            userName = verifyUser.data.name;

            showInfoDialog(
                230,
                _buildBody(
                  username: userName,
                ));
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.secondaryColor,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            cPageState(state: false);
          }
        } else {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.secondaryColor,
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void _completeTransfer() async {
    if (_emailController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'Enter reciepient email',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'enter amount to transfer',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['email_address'] = _emailController.text;
        map['amount'] = _amountController.text;
        map['userId'] = userId;

        var response =
            await http.post(HttpService.transferFund, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'The connection has timed out, please try again!',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5,
          );

          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          TransferFund transferFund = TransferFund.fromJson(body);

          bool status = transferFund.status;
          String message = transferFund.message;
          if (status) {
            cPageState(state: false);

            String balance = transferFund.data.balance.toString();
            String amountTransferred =
                transferFund.data.amountTransferred.toString();

            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.secondaryColor,
                value: "You have Sucessfully transfered " +
                    amountTransferred +
                    " to " +
                    userName,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);

            SharedPrefrences.addStringToSP("nairaBalance", balance);
          } else if (!status) {
            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.secondaryColor,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            cPageState(state: false);
          }
        } else {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.secondaryColor,
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        title: 'Mabro Transfer',
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      backgroundColor: ColorConstants.primaryColor,
      body: (pageState)
          ? loadingPage(state: pageState)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(children: <Widget>[
                  SafeArea(child: SizedBox(height: 5)),
                  _buildTransferForm(context),
                ]),
              ),
            ),
    );
  }

  void showInfoDialog(double height, Widget Widgets,
      {String title = 'ConfirmUser'}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Stack(
              children: [
                Container(
                  height: height,
                  color: ColorConstants.primaryColor,
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
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Widgets,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                  disableButton: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ShowSnackBar.showInSnackBar(
                                        bgColor: ColorConstants.secondaryColor,
                                        value: 'Transaction aborted',
                                        context: context,
                                        scaffoldKey: _scaffoldKey,
                                        timer: 5);
                                  },
                                  text: 'Cancel'),
                            ),
                            Expanded(
                              child: CustomButton(
                                  disableButton: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _completeTransfer();
                                  },
                                  text: 'Confirm'),
                            ),
                          ],
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

  Widget _buildBody({String username}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Transfer ' + _amountController.text + ' to ' + username,
            style: TextStyle(
                fontSize: 16, color: ColorConstants.whiteLighterColor),
          ),
          SizedBox(height: 20),
          Text(
            'Note: On transaction Successful this Process cannot be reversed.',
            style:
                TextStyle(fontSize: 16, color: ColorConstants.secondaryColor),
          ),
        ],
      ),
    );
  }
}
