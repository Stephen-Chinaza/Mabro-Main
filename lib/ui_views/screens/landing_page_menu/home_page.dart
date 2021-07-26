import 'dart:async';
import 'dart:math';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/home_wallet.dart';
import 'package:mabro/ui_views/screens/airtime_page/selected_mobile_carrier.dart';
import 'package:mabro/ui_views/screens/airtime_to_cash_pages/airtime_to_cash_page.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/p2p_buy_sell_page.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/main_lock_screen.dart';
import 'package:mabro/ui_views/screens/recieve_btc_page/recieve_btc_page.dart';
import 'package:mabro/ui_views/screens/contact_us_page/contact_us_page.dart';
import 'package:mabro/ui_views/screens/data_recharge_page/selected_data_recharge.dart';
import 'package:mabro/ui_views/screens/deposit_and_withdraw_funds_page/deposit_withdraw.dart';
import 'package:mabro/ui_views/screens/faq_page/faq.dart';
import 'package:mabro/ui_views/screens/giftcard_transactions_page.dart/buy_sell_giftcard_page.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/account_page.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/notifications_page.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/security.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mabro/ui_views/screens/news_page/news_update.dart';
import 'package:mabro/ui_views/screens/electricity_page/selected_electricity_page.dart';
import 'package:mabro/ui_views/screens/tv_subscription_pages/selected_cable_tv.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email, firstname, username;
  var mail, mail2;
  bool bankState;
  String accountNumber;

  @override
  void initState() {
    super.initState();
    email = '';
    firstname = '';
    username = '';
    mail = '';
    mail2 = '';
    bankState = false;
    getData();
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Evening';
    }
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = (pref.getString('email') ?? '');
    accountNumber = (pref.getString('account_number') ?? '');
    firstname = (pref.getString('first_name') ?? '');

    if (firstname == '') {
      username = '';
    } else {
      username = firstname;
    }

    setState(() {
      if (accountNumber == '') {
        bankState = true;
      } else {
        bankState = false;
      }

      if (bankState) {
        showInfoDialog(320, _buildBody(), title: 'Account setup');
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _buildDrawer(context),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          _buildToolbar(context),
          _buildMenuHeader(context, 'Quick access'),
          menuOption(context, _scaffoldKey),
          _buildSizedBox(20),
          _buildPictureDisplay(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSizedBox(double height) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height),
    );
  }

  SliverToBoxAdapter _buildToolbar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        child: Stack(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SafeArea(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState.openDrawer();
                                },
                                child: Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  greetingMessage(),
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  username,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: ColorConstants.primaryGradient,
                    ),
                    height: MediaQuery.of(context).size.height * 0.29,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Positioned(top: 120, right: 4, left: 6, child: HomeWallet())
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMenuHeader(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  SliverGrid menuOption(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    List<HomeMenu> subList = DemoData.menu;
    int checkedItem = 0;

    List<Widget> menuScreens = [
      BtcP2PBuySell(),
      BuySellGiftcardTran(),
      DepositWithdrawPage(),
      ReceiveBtcPage(),
      SelectedMobileCarrierPage(),
      AirtimeToCashPage(),
      SelectedDataRechargePage(),
      SelectedMobileCarrierPage(),
      SelectedCableTvPage(),
      SelectedElectricitySubPage(),
      SelectedElectricitySubPage(),
      NewsUpdatePage(),
    ];

    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              checkedItem = index;
              if (checkedItem == 1) {
                ShowSnackBar.showInSnackBar(
                    value: 'feature coming up soon!!!',
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    timer: 5);
              } else if (checkedItem == 4) {
                ShowSnackBar.showInSnackBar(
                    value: 'feature coming up soon!!!',
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    timer: 5);
              } else if (checkedItem == 10) {
                ShowSnackBar.showInSnackBar(
                    value: 'feature coming up soon!!!',
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    timer: 5);
              } else {
                kopenPage(context, menuScreens[checkedItem]);
              }
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      subList[index].icon,
                      size: 30,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        color: ColorConstants.transparent,
                        child: Center(
                          child: Text(
                            subList[index].title,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: subList.length,
      ),
    );
  }

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      gradient: ColorConstants.primaryGradient,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  'Hello',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  username ?? '',
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildDivider(),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(0),
                  dense: true, //removes additional space vertically
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.all(0),
                    childrenPadding: EdgeInsets.only(left: 20),
                    leading: Container(
                      height: 45,
                      width: 45,
                      child: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Typicons.chart_bar_outline,
                              size: 22,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text('Bitcoin P2P Exchange',
                        style: TextStyle(color: active, fontSize: 15)),
                    children: <Widget>[
                      _buildRow(
                        Icons.arrow_forward,
                        "BTC P2P Buy/Sell",
                        showBadge: false,
                        page: BtcP2PBuySell(),
                      ),
                      _buildRow(Icons.arrow_forward, "Transfer/Receive BTC",
                          showBadge: false, page: ReceiveBtcPage()),
                    ],
                  ),
                ),
                _buildDivider(),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.all(0),
                    childrenPadding: EdgeInsets.only(left: 20),
                    leading: Container(
                      height: 45,
                      width: 45,
                      child: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Typicons.spanner,
                              size: 22,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text('Bill Payment',
                        style: TextStyle(color: active, fontSize: 15)),
                    children: <Widget>[
                      _buildRow(
                        Icons.arrow_forward,
                        "Pay Electricity Bill",
                        page: SelectedElectricitySubPage(),
                      ),
                      _buildRow(
                        Icons.arrow_forward,
                        "Pay Tv Subscription",
                        page: SelectedCableTvPage(),
                      ),
                    ],
                  ),
                ),
                _buildDivider(),
                ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      childrenPadding: EdgeInsets.only(left: 20),
                      leading: Container(
                        height: 45,
                        width: 45,
                        child: Card(
                          elevation: 5,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: ColorConstants.primaryGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.data_usage,
                                size: 22,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text('Data / Airtime',
                          style: TextStyle(color: active, fontSize: 15)),
                      children: <Widget>[
                        _buildRow(
                          Icons.arrow_forward,
                          "Buy Airtime",
                          page: SelectedMobileCarrierPage(),
                        ),
                        _buildRow(
                          Icons.arrow_forward,
                          "Buy Data",
                          page: SelectedDataRechargePage(),
                        ),
                      ],
                    )),
                _buildDivider(),
                ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.only(left: 0),
                      childrenPadding: EdgeInsets.only(left: 20),
                      leading: Container(
                        height: 45,
                        width: 45,
                        child: Card(
                          elevation: 5,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: ColorConstants.primaryGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.settings,
                                size: 22,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text('Settings',
                          style: TextStyle(
                            color: active,
                            fontSize: 15,
                          )),
                      children: <Widget>[
                        _buildRow(
                          Icons.arrow_forward,
                          "Accounts",
                          page: AccountPage(),
                        ),
                        _buildRow(
                          Icons.arrow_forward,
                          "Security",
                          page: SecurityPage(),
                        ),
                      ],
                    )),
                _buildDivider(),
                _buildRow(
                  Icons.card_giftcard,
                  "Sell / Buy GiftCards",
                  showBadge: false,
                  openState: false,
                ),
                _buildDivider(),
                _buildRow(
                  Icons.dashboard_customize,
                  "Deposit / Withdrawal",
                  showBadge: false,
                  page: DepositWithdrawPage(),
                ),
                _buildDivider(),
                _buildRow(
                  Icons.money,
                  "Buy Social Media Likes",
                  openState: false,
                ),
                _buildDivider(),
                _buildRow(
                  Icons.subscriptions,
                  "Airtime to Cash",
                  page: AirtimeToCashPage(),
                ),
                _buildDivider(),
                _buildRow(Icons.notifications, "Notifications",
                    showBadge: true, page: NotificationsPage()),
                _buildDivider(),
                _buildRow(Icons.phone, "Contact us",
                    page: ContactUs(
                        cardColor: Colors.white,
                        textColor: ColorConstants.secondaryColor,
                        //logo: AssetImage('assets/images/mbl2.png'),
                        email: 'adoshi26.ad@gmail.com',
                        companyName: 'Abhishek Doshi',
                        companyColor: ColorConstants.secondaryColor,
                        phoneNumber: '+917818044311',
                        website: 'https://google.com',
                        githubUserName: 'AbhishekDoshi26',
                        linkedinURL:
                            'https://www.linkedin.com/in/abhishek-doshi-520983199/',
                        tagLine: 'Mabro Connect',
                        taglineColor: ColorConstants.secondaryColor,
                        twitterHandle: 'AbhishekDoshi26',
                        instagram: '_abhishek_doshi',
                        facebookHandle: '_abhishek_doshi')),
                _buildDivider(),
                _buildRow(Icons.info_outline, "FAQ", page: FAQPage()),
                _buildDivider(),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    kopenPage(context, MainScreenLock());
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: ColorConstants.primaryGradient,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      height: 8,
    );
  }

  Widget _buildRow(IconData icon, String title,
      {Widget page, bool showBadge = false, bool openState = true}) {
    final TextStyle tStyle =
        TextStyle(color: active, fontSize: 15, fontWeight: FontWeight.normal);
    return GestureDetector(
      onTap: () => {
        Navigator.pop(context),
        (openState)
            ? kopenPage(context, page)
            : ShowSnackBar.showInSnackBar(
                value: 'feature coming up soon!!!',
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5)
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            height: 45,
            width: 45,
            child: Card(
              elevation: 5,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: ColorConstants.primaryGradient,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    icon,
                    size: 22,
                    color: ColorConstants.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: tStyle,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPictureDisplay() {
    return SliverToBoxAdapter(
        child: Container(
      height: 180,
      child: Card(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              length: 2,
              indicatorSpace: 12.0,
              padding: EdgeInsets.only(bottom: 0),
              indicatorColor: ColorConstants.grey,
              indicatorSelectorColor: ColorConstants.primaryColor,
              shape: IndicatorShape.circle(size: 8),
              child: PageView(
                children: <Widget>[
                  Image.asset('assets/images/crypto4.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/crypto3.jpg', fit: BoxFit.cover)
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void showInfoDialog(double height, Widget Widgets, {String title = 'Info'}) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: ColorConstants.primaryGradient),
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
                                      fontWeight: FontWeight.bold),
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
                                        size: 30,
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
                        CustomButton(
                            disableButton: true,
                            onPressed: () {
                              Navigator.pop(context);
                              kopenPage(context, AccountPage());
                            },
                            text: 'Proceed'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildBody() {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/crypto4.jpg',
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Please to continue enjoying your smooth transactions with MABRO add your account details.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}