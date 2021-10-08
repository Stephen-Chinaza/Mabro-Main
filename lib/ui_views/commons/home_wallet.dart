import 'package:intl/intl.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/wallet_container.dart';
import 'package:mabro/ui_views/screens/all_wallets_page/all_wallets_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/screens/landing_page_menu/wallet_page.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWallet extends StatefulWidget {
  @override
  _HomeWalletState createState() => _HomeWalletState();
}

class _HomeWalletState extends State<HomeWallet> with TickerProviderStateMixin {
  String nairaBalance = '';
  String btcBalance = '';

  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nairaBalance = (pref.getString('nairaBalance') ?? '');
    btcBalance = (pref.getString('bitcoin_balance') ?? '');

    setState(() {});
  }

  getCurrentDate() {
    return new DateFormat.yMMMMd().add_jm().format(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),
        color: ColorConstants.transparent,
      ),
      child: Card(
        elevation: 10,
        color: ColorConstants.primaryLighterColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            color: ColorConstants.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageIndicatorContainer(
                align: IndicatorAlign.bottom,
                length: 1,
                indicatorSpace: 12.0,
                padding: EdgeInsets.only(bottom: 0),
                indicatorColor: ColorConstants.white,
                indicatorSelectorColor: ColorConstants.primaryColor,
                shape: IndicatorShape.circle(size: 0),
                child: PageView(
                  children: <Widget>[
                    BalanceCard(
                      bg: false,
                      image: 'assets/images/naira.jpg',
                      title: 'Naira Wallet',
                      amount: "NGN" + nairaBalance + ".00",
                      nairaEquiv: '',
                      onClickOpenPage: 'View wallets',
                      dateTime: getCurrentDate().toString(),
                      onTapped: () => kopenPage(context, WalletPage()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
