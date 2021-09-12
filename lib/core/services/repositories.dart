import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/core/models/all_transactions_history.dart';
import 'package:mabro/core/models/list_bank.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  static final String https = 'https://iceztech.com/mabro/';

  static var rootReg = Uri.parse('https://iceztech.com/mabro/account/create-m');
  static var rootLogin =
      Uri.parse('https://iceztech.com/mabro/account/login-m');
  static var rootVerifyEmail =
      Uri.parse('https://iceztech.com/mabro/account/verify-email-code-m');
  static var rootUserPin =
      Uri.parse('https://iceztech.com/mabro/settings/create-lock-code-m');
  static var rootVerifyPhone =
      Uri.parse('https://iceztech.com/mabro/account/verifyPhoneCodeM');
  static var rootSendPhone =
      Uri.parse('https://iceztech.com/mabro/account/sendPhoneCodeM');
  static var rootSettingsInfo =
      Uri.parse('https://iceztech.com/mabro/settings/index/');
  static var rootUpdateUsersData =
      Uri.parse('https://iceztech.com/mabro/settings/update-profile');
  static var rootWithdrawFund =
      Uri.parse('https://iceztech.com/mabro/fund-account/withdraw');
  static var rootUpdateSettings =
      Uri.parse('https://iceztech.com/mabro/settings/update-settings');
  static var rootUpdateUserPassword =
      Uri.parse('https://iceztech.com/mabro/settings/update-password');
  static var rootUpdateUserPin =
      Uri.parse('https://iceztech.com/mabro/settings/change-lock-code');
  static var rootVerifyAccountNumber =
      Uri.parse('https://iceztech.com/mabro/settings/verify-account-number');
  static var rootVerifyBvn =
      Uri.parse('https://iceztech.com/mabro/settings/verify-bvn');
  static var rootUpdateAccount =
      Uri.parse('https://iceztech.com/mabro/settings/add-account-number');
  static var rootBuyAirtime =
      Uri.parse('https://iceztech.com/mabro/airtime/buy');

  static Future<ListBanks> getBankLists(BuildContext context) async {
    try {
      var map = Map<String, dynamic>();

      var response = await http
          .post(Uri.parse('https://iceztech.com/mabro/settings/banks'),
              body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        ListBanks banks = ListBanks.fromJson(body);

        bool status = banks.status;
        String message = banks.message;
        if (status) {
          // ShowSnackBar.showInSnackBar(
          //     bgColor: Colors.green,
          //     iconData: Icons.check_circle,
          //     value: message,
          //     context: context,
          //     timer: 5);

          return banks;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: message,
              context: context,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'network error',
            context: context,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'check your internet connection',
          context: context,
          timer: 5);
    }
  }

  static Future<AllTransactionHistory> transactionHistory(
      BuildContext context, String user, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['user'] = user;

      var response = await http
          .post(Uri.parse(url), body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        AllTransactionHistory allTransactionHistory =
            AllTransactionHistory.fromJson(body);

        bool status = allTransactionHistory.status;
        String message = allTransactionHistory.message;
        if (status) {
          return allTransactionHistory;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: message,
              context: context,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'network error',
            context: context,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'check your internet connection',
          context: context,
          timer: 5);
    }
  }
}
