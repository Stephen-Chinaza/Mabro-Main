import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class DemoData {
  static List<HomeMenu> get menu => [
        HomeMenu(
          title: "P2P \n Exchange",
          icon: Typicons.chart_line,
        ),
        HomeMenu(
          title: "Giftcard",
          icon: Typicons.gift,
        ),
        HomeMenu(
          title: "Deposit/Withdraw",
          icon: Typicons.device_laptop,
        ),
        HomeMenu(
          title: "Receive/Transfer BTC",
          icon: Typicons.globe,
        ),
        HomeMenu(
          title: "Buy Social Media Likes",
          icon: Typicons.social_facebook,
        ),
        HomeMenu(
          title: "Airtime To Cash",
          icon: Typicons.device_phone,
        ),
        HomeMenu(
          title: "Buy Data",
          icon: Typicons.credit_card,
        ),
        HomeMenu(
          title: "Buy Airtime",
          icon: Typicons.device_phone,
        ),
        HomeMenu(title: "Tv Subscription", icon: Typicons.social_youtube),
        HomeMenu(title: "Electricity", icon: Typicons.export_outline),
        HomeMenu(title: "Education", icon: Typicons.social_github),
        HomeMenu(
          title: "Updates",
          icon: Icons.info,
        ),
      ];

  static List<HomeMenu> get subs => [
        HomeMenu(
          title: "Data Recharge",
          icon: Icons.data_usage_sharp,
        ),
        HomeMenu(
          title: "Quick Airtime",
          icon: Icons.receipt_long_sharp,
        ),
        HomeMenu(
          title: "Tv Subscription",
          icon: Icons.tv,
        ),
        HomeMenu(
          title: "Electricity",
          icon: Icons.wifi_rounded,
        ),
        HomeMenu(
          title: "Updates",
          icon: Icons.info,
        ),
      ];

  static List<ImageList> get images => [
        ImageList(image: 'assets/images/mtn.png', title: 'MTN'),
        ImageList(image: 'assets/images/glo.png', title: 'GLO'),
        ImageList(image: 'assets/images/airtel.png', title: 'AIRTEL'),
        ImageList(image: 'assets/images/9mobile.png', title: '9MOBILE'),
      ];

  static List<ImageList> get subImages => [
        ImageList(image: 'assets/images/dstv.jpg', title: 'DSTV'),
        ImageList(image: 'assets/images/gotv.png', title: 'GOTV'),
        ImageList(image: 'assets/images/startimes.jpg', title: 'STARTIMES'),
      ];

  static List<ImageList> get electricityImages => [
        ImageList(
            image: 'assets/images/ekoelect.jpg',
            title: 'Eko Electricity Distribution Company'),
        ImageList(
            image: 'assets/images/ikejaelect.png',
            title: 'Ikeja Electricity Distribution Company'),
        ImageList(
            image: 'assets/images/kanoelect.png',
            title: 'Kano Electricity Distribution Company'),
        ImageList(
            image: 'assets/images/eedcelect.png',
            title: 'Enugu Electricity Distribution Company'),
      ];

  static List<TextList> get text => [
        TextList(text: 'Mabro NGN Wallet'),
        TextList(text: 'Bank transfer'),
      ];

  static List<CoinList> get coinlists => [
        CoinList(
            title: 'Bitcoin',
            image: 'assets/images/btc.jpg',
            subtitle: 'BTC',
            rate: '19,780,207.92',
            rise: '+ 1.50%',
            usdRate: 'bitUSD'),
      ];

  static List<AirtimeList> get airtime => [
        AirtimeList(amount: 'NGN100'),
        AirtimeList(amount: 'NGN200'),
        AirtimeList(amount: 'NGN300'),
        AirtimeList(amount: 'NGN400'),
        AirtimeList(amount: 'NGN500'),
        AirtimeList(amount: 'NGN1000'),
        AirtimeList(amount: 'NGN2000'),
      ];

  static List<String> banks = [
    ' Access Bank Plc',
    'Citibank Nigeria Limited',
    'Diamond Bank Plc',
    'Ecobank Nigeria Plc',
    'Fidelity Bank Plc',
    'First Bank Of Nigeria LTD',
    'First City Monument Bank Plc',
    'Guaranty Trust Bank Plc',
    'Heritage Banking Company LTD',
    'Keystone Bank Limited',
    'Polaris Bank Limited',
    'Providus Bank Limited',
    'Stanbic IBTC Bank Ltd',
    'Standard Chartered Bank Nigeria Ltd',
    'Sterling Bank Plc',
    'SunTrust Bank Nigeria Limited',
    'Union Bank of Nigeria Plc',
    'United Bank For Africa Plc',
    'Unity Bank Plc',
    'Wema Bank Plc',
    'Zenith Bank Plc'
  ];
}

class HomeMenu {
  final String title;
  final IconData icon;

  HomeMenu({this.title, this.icon});
}

class ImageList {
  final String image;
  final String title;

  ImageList({this.title, this.image});
}

class AirtimeList {
  final String amount;

  AirtimeList({this.amount});
}

class TextList {
  final String text;

  TextList({this.text});
}

class CoinList {
  final String title;
  final String image;
  final String subtitle;
  final String rise;
  final String rate;
  final String usdRate;

  CoinList({
    this.subtitle,
    this.rise,
    this.rate,
    this.image,
    this.title,
    this.usdRate,
  });
}
