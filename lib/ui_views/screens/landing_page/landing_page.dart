import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/bottom_navigation_bar.dart/bottom_navigation_bar.dart';
import 'package:mabro/ui_views/screens/landing_page_menu/all_transactions.dart';
import 'package:mabro/ui_views/screens/landing_page_menu/home_page.dart';
import 'package:mabro/ui_views/screens/landing_page_menu/profile_page.dart';
import 'package:mabro/ui_views/screens/landing_page_menu/wallet_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  bool isFirstScreen;

  LandingPage({Key key, this.isFirstScreen = true}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController pageController = PageController(initialPage: 0);

  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  String userId;
  String userPin = '';
  bool pinState;

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    pinState = (pref.getBool('pinState') ?? false);
    userPin = (pref.getString('lock_code') ?? '');

    if(userPin != ''){
      SharedPrefrences.addBoolToSP('pinState', true);
    }else{
      SharedPrefrences.addBoolToSP('pinState', false);
    }

  }

  @override
  void initState() {
    super.initState();
    checkFirstScreen();

    checkFirstScreen().whenComplete(() => {
      setState(()=>{})
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          HomePage(),
          WalletPage(),
          AllTransactions(
            user: userId,
          ),
          MenuPage(),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              activeColor: ColorConstants.white,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text('Home'),
                ),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.account_balance_wallet),
                    title: Text('Wallet')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.history), title: Text('History')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person), title: Text('Profile')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}
