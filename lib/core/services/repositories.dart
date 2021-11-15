import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/core/models/all_transactions_history.dart';
import 'package:mabro/core/models/buy_9mobile_bundle.dart';
import 'package:mabro/core/models/buy_airtel_bundle.dart';
import 'package:mabro/core/models/buy_glo_bundle.dart';
import 'package:mabro/core/models/buy_mtn_bundle.dart';
import 'package:mabro/core/models/electricity_data_companies.dart';
import 'package:mabro/core/models/list_bank.dart';
import 'package:mabro/core/models/p2p_models/exchangeInfo.dart';
import 'package:mabro/core/models/p2p_models/list_coins.dart';
import 'package:mabro/core/models/tv_data_companies/dstv.dart';
import 'package:mabro/core/models/tv_data_companies/gotv.dart';
import 'package:mabro/core/models/tv_data_companies/startimes_data.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  static final String https = 'https://iceztech.com/mabro/';
  static final String token =
      'kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=';

  static var rootReg = Uri.parse('https://mabro.ng/dev3/register/create');
  static var verifyTransfer =
      Uri.parse('https://mabro.ng/dev3/_app/transfer/user/verify');
  static var transferFund =
      Uri.parse('https://mabro.ng/dev3/_app/transfer/user/process');
  static var rootVerifyTransfer =
      Uri.parse('https://mabro.ng/dev3/_app/transfer/bank/verify');
  static var rootTransferFund =
      Uri.parse('https://mabro.ng/dev3/_app/transfer/bank/process');
  static var rootUserInfo =
      Uri.parse('https://mabro.ng/dev3/_app/account-details');
  static var rootAirCashInfo =
      Uri.parse('https://mabro.ng/dev3/_app/airtime-to-cash/data');
  static var rootAirCashSubmit =
      Uri.parse('https://mabro.ng/dev3/_app/airtime-to-cash/process');
  static var rootLogin = Uri.parse('https://mabro.ng/dev3/login/authenticate');
  static var rootForgotPassword =
      Uri.parse('https://mabro.ng/dev3/login/send-OTP');
  static var rootSendEmailOtp =
      Uri.parse('https://mabro.ng/dev3/register/verify-email-OTP');
  static var rootVerifyEmail =
      Uri.parse('https://mabro.ng/dev3/register/verify-email-OTP');
  static var rootResetPassword =
      Uri.parse('https://mabro.ng/dev3/login/create-password');
  static var rootResendEmail =
      Uri.parse('https://mabro.ng/dev3/register/send-email-OTP');
  static var rootUserPin =
      Uri.parse('https://mabro.ng/dev3/register/create-lock-code');
  static var rootVerifyPhone =
      Uri.parse('https://mabro.ng/dev3/_app/verify-phone-OTP');
  static var rootResendPhone =
      Uri.parse('https://mabro.ng/dev3/_app/update-phone');
  static var rootSendPhone =
      Uri.parse('https://mabro.ng/dev3/_app/update-phone');

  static var rootUpdateSettings =
      Uri.parse('https://mabro.ng/dev3/_app/update-settings');
  static var rootUpdateUserPassword =
      Uri.parse('https://mabro.ng/dev3/_app/change-password');
  static var rootUpdateUserPin =
      Uri.parse('https://mabro.ng/dev3/_app/change-lock-code');

  static var rootVerifyBvn = Uri.parse('https://mabro.ng/dev3/_app/add-BVN');
  static var rootUpdateAccount =
      Uri.parse('https://mabro.ng/dev3/_app/update-bank-account');
  static var rootBuyAirtime =
      Uri.parse('https://mabro.ng/dev3/_app/airtime/pay');
  static var rootBuyData =
      Uri.parse('https://mabro.ng/dev3/_app/mobile-data/pay');
  static var rootVerifyMeterNumber =
      Uri.parse('https://mabro.ng/dev3/_app/electricity/verify-meter-number');
  static var rootPayElectricityBill =
      Uri.parse('https://mabro.ng/dev3/_app/electricity/pay-bill');
  static var rootElectricityCompanyList =
      'https://mabro.ng/dev3/_app/electricity/distribution-companies';
  static var rootPayTvBill =
      Uri.parse('https://mabro.ng/dev3/_app/tv/pay-subscription');
  static var rootTvSubscriptionList =
      'https://mabro.ng/dev3/_app/electricity/distribution-companies';
  static var rootTvPlanList =
      'https://mabro.ng/dev3/_app/electricity/distribution-companies';
  static var rootVerifySmartCard =
      Uri.parse('https://mabro.ng/dev3/_app/tv/verify-smart-card');
  static var rootVerifyCardPayment =
      Uri.parse('https://mabro.ng/dev3/_app/naira-wallet/fund');
  static var rootVerifyOtp =
      Uri.parse('https://mabro.ng/dev3/_app/naira-wallet/verify-OTP');

  //P2p Urls
  static var rootP2PUserInfo =
      Uri.parse('https://mabro.ng/dev3/exchange/info/coins');
  static var rootCreateBuyAdInfo =
      Uri.parse('https://mabro.ng/dev3/exchange/btc/buy/create-ad/save');

  static Future<ListBanks> getBankLists(BuildContext context, userId) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      var response = await http.post(
          Uri.parse('https://mabro.ng/dev/_app/list-banks'),
          body: map,
          headers: {
            'Authorization': 'Bearer ' + HttpService.token,
          }).timeout(const Duration(seconds: 15), onTimeout: () {
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
          return banks;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<ListCoinsDetails> getCoinLists(
      BuildContext context, userId) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;
      var response = await http.post(
          Uri.parse('https://mabro.ng/dev2/exchange/info/coins'),
          body: map,
          headers: {
            'Authorization': 'Bearer ' + HttpService.token,
          }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        ListCoinsDetails listCoinsDetails = ListCoinsDetails.fromJson(body);

        bool status = listCoinsDetails.status;
        String message = listCoinsDetails.message;
        if (status) {
          return listCoinsDetails;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<dataMtnList> dataMtnPlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        dataMtnList data = dataMtnList.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          print(data);
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<DstvCompany> dstvPlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        DstvCompany data = DstvCompany.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          print(data);
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<StartimesDataCompany> startimesPlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        StartimesDataCompany data = StartimesDataCompany.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<GotvDataCompany> gotvPlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        GotvDataCompany data = GotvDataCompany.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          print(data);
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<dataAirtelList> dataAirtelPlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        dataAirtelList data = dataAirtelList.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          print(data);
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<dataGloList> dataGloPlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        dataGloList data = dataGloList.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<data9mobileList> data9mobilePlanList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        data9mobileList data = data9mobileList.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          print(data);
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<ElectricityCompanyList> electricityCompanyList(
      BuildContext context, String userId, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            context: context,
            timer: 5);
        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        ElectricityCompanyList data = ElectricityCompanyList.fromJson(body);

        bool status = data.status;
        String message = data.message;
        if (status) {
          return data;
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<AllTransactionHistory> transactionHistory(
      BuildContext context, String user, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = user;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
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
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }

  static Future<AllTransactionHistory> coinLists(
      BuildContext context, String user, String url) async {
    try {
      var map = Map<String, dynamic>();
      map['userId'] = user;

      var response = await http.post(Uri.parse(url), body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
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
              value: message, context: context, timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error', context: context, timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection', context: context, timer: 5);
    }
  }
}
