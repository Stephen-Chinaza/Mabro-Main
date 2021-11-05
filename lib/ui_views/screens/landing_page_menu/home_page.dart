import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/airtime_to_cash_info.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/models/p2p_models/exchangeInfo.dart';
import 'package:mabro/core/models/update_account.dart';
import 'package:mabro/core/models/userInfo.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/home_wallet.dart';
import 'package:mabro/ui_views/screens/airtime_page/selected_mobile_carrier.dart';
import 'package:mabro/ui_views/screens/airtime_to_cash_pages/airtime_to_cash_page.dart';
import 'package:mabro/ui_views/screens/bank_transfer/other_bank_transfer.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/p2p_buy_sell_page.dart';
import 'package:mabro/ui_views/screens/coin_exchange_page/coin_exchange.dart';
import 'package:mabro/ui_views/screens/education_page/selected_education_sub.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/main_lock_screen.dart';
import 'package:mabro/ui_views/screens/mabro_transfer_page/mabro_transfer.dart';
import 'package:mabro/ui_views/screens/naira_transactions_pages/naira_wallet_page.dart';
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
import 'package:mabro/ui_views/screens/electricity_page/selected_electricity_page.dart';
import 'package:mabro/ui_views/screens/tv_subscription_pages/selected_cable_tv.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email, firstname, username, userId;
  var mail, mail2;
  bool bankState;
  String accountNumber;
  String nairaBalance = '';

  List<CoinList> coinList = [];

  String saleStatus = 'p2pBuy';

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

    coinList = DemoData.coinlists;

    getUserInfo();
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

  var formatter = NumberFormat("#,##0.00", "en_US");

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    email = (pref.getString('email') ?? '');
    accountNumber = (pref.getString('account_number') ?? '');
    firstname = (pref.getString('first_name') ?? '');

    nairaBalance = (pref.getString('nairaBalance') ?? '');

    setState(() {
      nairaBalance = formatter.format(int.tryParse(nairaBalance));
    });

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
        showInfoDialog(310, _buildBody(), title: 'Account setup');
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.primaryColor,
      drawer: _buildDrawer(context),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          _buildToolbar(context),
          _buildSizedBox(10),
          _buildMenu1(),
          _buildSizedBox(10),
          _buildWallet(),
          _buildSizedBox(10),
          _buildMenu2(),
          _buildSizedBox(10),
          _buildMenu3(),

          //menuOption(context, _scaffoldKey),
          //_buildSizedBox(5),
          //_buildPictureDisplay(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildMenu1() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: _menuContainers(
          title: 'Mobile Transactions',
          iconBg1: Colors.yellow,
          iconData1: Typicons.device_phone,
          menuTitle1: 'Buy Airtime',
          page1: SelectedMobileCarrierPage(),
          iconBg2: Colors.blue,
          iconData2: Icons.money,
          menuTitle2: 'Airtime 2 Cash',
          page2: AirtimeToCashPage(),
          iconBg3: Colors.purple,
          iconData3: Typicons.compass,
          menuTitle3: 'Buy Data',
          page3: SelectedDataRechargePage(),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMenu2() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: _menuContainers2(
        title: 'Bill Payment',
        iconBg1: Colors.orange,
        iconData1: Typicons.device_phone,
        menuTitle1: 'Tv Subscription',
        page1: SelectedCableTvPage(),
        iconBg2: ColorConstants.secondaryColor,
        iconData2: Icons.money,
        menuTitle2: 'Electricity Bill',
        page2: SelectedElectricitySubPage(),
        menuHeight: 130,
        containerHeight: 190,
      ),
    ));
  }

  SliverToBoxAdapter _buildMenu3() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: _menuContainers2(
        title: 'P2P Exchange',
        iconBg1: Colors.green,
        iconData1: Icons.attribution_outlined,
        menuTitle1: 'Buy',
        function: true,
        iconBg2: ColorConstants.secondaryColor,
        iconData2: Icons.account_tree_sharp,
        menuTitle2: 'Sell',
        tap1: _p2PUserInfo,
        tap2: _p2PUserInfo,
        menuHeight: 130,
        containerHeight: 190,
      ),
    ));
  }

  SliverToBoxAdapter _buildSizedBox(double height) {
    return SliverToBoxAdapter(child: SizedBox(height: height));
  }

  SliverToBoxAdapter _buildWallet() {
    return SliverToBoxAdapter(
      child: Container(
          child: CarouselSlider.builder(
        itemCount: coinList.length + 1,
        options: CarouselOptions(
          aspectRatio: 3.0,
          pageSnapping: true,
          enlargeCenterPage: false,
          viewportFraction: 0.6,
          pauseAutoPlayOnTouch: true,
          autoPlayCurve: Curves.linear,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          disableCenter: true,
          enableInfiniteScroll: true,
          autoPlay: true,
        ),
        itemBuilder: (ctx, index, realIdx) {
          return GestureDetector(
            onTap: () {
              setState(() {
                saleStatus = 'exchange';
              });
              (index == 0)
                  ? kopenPage(
                      context,
                      NairaWalletPage(
                        user: userId,
                      ),
                    )
                  : _p2PUserInfo(
                      index: index,
                      image: coinList[index - 1].image,
                      coinTitle: coinList[index - 1].subtitle);
            },
            child: Container(
              height: 100,
              width: 150,
              child: Card(
                  color: ColorConstants.primaryLighterColor,
                  child: (index == 0)
                      ? _buildWalletItem(
                          coinName: 'Naira Wallet',
                          nairaEquivalent: nairaBalance,
                          image: 'assets/images/naira.png',
                          coinColor: Colors.green,
                          coinBalance: 'Balance')
                      : _buildWalletItem(
                          coinName: coinList[index - 1].title + ' Balance',
                          nairaEquivalent: coinList[index - 1].nairaPrice,
                          image: coinList[index - 1].image,
                          coinBalance: coinList[index - 1].coinPrice,
                          coinColor: coinList[index - 1].color)),
            ),
          );
        },
      )),
    );
  }

  Widget _buildWalletItem(
      {String coinName,
      String nairaEquivalent,
      String image,
      String coinBalance,
      Color coinColor}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coinName,
                style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text(
                nairaEquivalent,
                style: TextStyle(
                    color: ColorConstants.whiteColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 2),
              Text(
                coinBalance,
                style: TextStyle(
                    color: coinColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 14),
            child: Image.asset(image, height: 40, width: 40),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildToolbar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 440,
        child: Stack(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 20,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, left: 8.0),
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
                                    color: ColorConstants.whiteLighterColor,
                                  )),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    greetingMessage(),
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18,
                                      color: ColorConstants.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    username,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18,
                                      color: ColorConstants.whiteLighterColor,
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
                        color: ColorConstants.primaryLighterColor,
                      ),
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 100,
                right: 0,
                left: 0,
                child: Material(
                  elevation: 20,
                  child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: ColorConstants.primaryGradient1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/images/naira.png',
                                height: 40, width: 40),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Wallet Balance',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )),
                              SizedBox(height: 8),
                              Text(nairaBalance,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  )),
                            ],
                          )
                        ],
                      )),
                )),
            Positioned(
                top: 165,
                right: 1,
                left: 1,
                child: _menuContainers(
                  title: 'Banking Activities',
                  iconBg1: Colors.deepOrange,
                  iconData1: Icons.transfer_within_a_station,
                  menuTitle1: 'Mabro Transfer',
                  page1: MabroTransferPage(),
                  iconBg2: ColorConstants.secondaryColor,
                  iconData2: Icons.house_siding_sharp,
                  menuTitle2: 'Other Bank Transfer',
                  page2: BankTransferPage(),
                  iconBg3: Colors.green,
                  iconData3: Typicons.device_laptop,
                  menuTitle3: 'Fund Wallet',
                  page3: DepositWithdrawPage(
                    indexNum: 0,
                  ),
                )),
            // Positioned(top: 100, right: 4, left: 6, child: HomeWallet())
          ],
        ),
      ),
    );
  }

  Widget _menuContainers(
      {IconData iconData1,
      Color iconBg1,
      String title,
      String menuTitle1,
      IconData iconData2,
      Color iconBg2,
      String menuTitle2,
      IconData iconData3,
      Color iconBg3,
      String menuTitle3,
      Widget page1,
      Widget page2,
      Widget page3,
      double containerHeight = 270,
      double menuHeight = 100}) {
    return Container(
      height: containerHeight,
      child: Material(
          color: ColorConstants.primaryLighterColor,
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Divider(height: 8, color: ColorConstants.whiteLighterColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              kopenPage(context, page1);
                            },
                            child: Container(
                              height: menuHeight,
                              width: 168,
                              child: Material(
                                color: ColorConstants.primaryColor,
                                child: _buildContent(
                                    menuTitle: menuTitle1,
                                    iconBg: iconBg1,
                                    iconData: iconData1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              kopenPage(context, page2);
                            },
                            child: Container(
                              height: menuHeight,
                              width: 168,
                              child: Material(
                                color: ColorConstants.primaryColor,
                                child: _buildContent(
                                    menuTitle: menuTitle2,
                                    iconBg: iconBg2,
                                    iconData: iconData2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        kopenPage(context, page3);
                      },
                      child: Container(
                          height: 204,
                          width: 160,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Material(
                              color: ColorConstants.primaryColor,
                              child: _buildContent(
                                  menuTitle: menuTitle3,
                                  iconBg: iconBg3,
                                  iconData: iconData3),
                            ),
                          )),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget _menuContainers2({
    IconData iconData1,
    Color iconBg1,
    String title,
    bool function = false,
    String menuTitle1,
    IconData iconData2,
    Color iconBg2,
    String menuTitle2,
    double containerHeight = 270,
    double menuHeight = 100,
    Widget page1,
    Widget page2,
    Function tap1,
    Function tap2,
  }) {
    return Container(
      height: containerHeight,
      child: Material(
          color: ColorConstants.primaryLighterColor,
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Divider(height: 8, color: ColorConstants.whiteLighterColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                saleStatus = 'p2pBuy';
                              });

                              (function == false)
                                  ? kopenPage(context, page1)
                                  : tap1();
                            },
                            child: Container(
                              height: menuHeight,
                              width: 168,
                              child: Material(
                                color: ColorConstants.primaryColor,
                                child: _buildContent(
                                    menuTitle: menuTitle1,
                                    iconBg: iconBg1,
                                    iconData: iconData1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          saleStatus = 'p2pSell';
                        });
                        (function == false)
                            ? kopenPage(context, page2)
                            : tap2();
                      },
                      child: Container(
                        height: menuHeight,
                        width: 168,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Material(
                            color: ColorConstants.primaryColor,
                            child: _buildContent(
                                menuTitle: menuTitle2,
                                iconBg: iconBg2,
                                iconData: iconData2),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget _buildContent({IconData iconData, Color iconBg, String menuTitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconBg,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              iconData,
              size: 20,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: ColorConstants.transparent,
            child: Center(
              child: Text(
                menuTitle,
                style: TextStyle(
                    color: ColorConstants.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _openPage(Widget page) {
    kopenPage(context, page);
  }

  SliverToBoxAdapter _buildMenuHeader(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: ColorConstants.secondaryColor,
                  fontWeight: FontWeight.w300),
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
      MabroTransferPage(),
      BankTransferPage(),
      DepositWithdrawPage(
        indexNum: 0,
      ),
      DepositWithdrawPage(
        indexNum: 1,
      ),
      NairaWalletPage(
        user: userId,
      ),
      BtcP2PBuySell(),
      ReceiveBtcPage(),
      AirtimeToCashPage(),
      SelectedDataRechargePage(),
      SelectedMobileCarrierPage(),
      SelectedCableTvPage(),
      SelectedElectricitySubPage(),
      //SelectedEducationSubPage(),
      //BuySellGiftcardTran(),
      //SelectedMobileCarrierPage(),
      //NewsUpdatePage(),
    ];

    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              checkedItem = index;
              if (checkedItem == 5) {
                //_p2PUserInfo();
              } else if (checkedItem == 7) {
                _airtime2CashInfo();
              } else {
                kopenPage(context, menuScreens[checkedItem]);
              }
            },
            child: Card(
              elevation: 3,
              color: ColorConstants.primaryLighterColor,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(
                      color: ColorConstants.whiteLighterColor, width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: ColorConstants.whiteLighterColor,
                        color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                        // color: Colors
                        //     .primaries[Random().nextInt(Colors.primaries.length)],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          subList[index].icon,
                          size: 18,
                          color: Colors.black87,
                        ),
                      ),
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
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
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

  final Color primary = ColorConstants.primaryColor;
  final Color active = ColorConstants.whiteLighterColor;
  final Color divider = Colors.grey.shade600;

  _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: ColorConstants.primaryColor,
            boxShadow: [BoxShadow(color: Colors.black45)]),
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
                        border: Border.all(
                            color: ColorConstants.whiteLighterColor,
                            width: 0.2)),
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
                      color: ColorConstants.secondaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  username ?? '',
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),

                // ListTileTheme(
                //   contentPadding: EdgeInsets.all(0),
                //   dense: true, //removes additional space vertically
                //   child: ExpansionTile(
                //     tilePadding: EdgeInsets.all(0),
                //     childrenPadding: EdgeInsets.only(left: 20),
                //     leading: Container(
                //       height: 43,
                //       width: 43,
                //       child: Card(
                //         elevation: 5,
                //         color: Colors.transparent,
                //         shape: RoundedRectangleBorder(
                //           side: new BorderSide(color: ColorConstants.whiteLighterColor,
                //               width: 0.2),
                //           borderRadius: BorderRadius.all(Radius.circular(50.0)),
                //
                //         ),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             gradient:  ColorConstants.primaryGradient,
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(50.0)),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(6.0),
                //             child: Icon(
                //               Typicons.chart_bar_outline,
                //               size: 18,
                //               color: ColorConstants.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     title: Text('Bitcoin P2P Exchange',
                //         style: TextStyle(color: active, fontSize: 14)),
                //     children: <Widget>[
                //       _buildRow(
                //         Icons.arrow_forward,
                //         "BTC P2P Buy/Sell",
                //         showBadge: false,
                //         page: BtcP2PBuySell(),
                //       ),
                //       _buildRow(Icons.arrow_forward, "Transfer/Receive BTC",
                //           showBadge: false, page: ReceiveBtcPage()),
                //     ],
                //   ),
                // ),
                // _buildDivider(),
                _buildRow(
                  "Airtime to Cash",
                  icon: Icons.subscriptions,
                  isMethod: true,
                ),
                ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    iconColor: Colors.white,
                    child: ExpansionTile(
                      iconColor: Colors.white,
                      tilePadding: EdgeInsets.all(0),
                      childrenPadding: EdgeInsets.only(left: 20),
                      leading: Container(
                        height: 45,
                        width: 45,
                        child: Card(
                          elevation: 5,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: new BorderSide(
                                color: ColorConstants.whiteLighterColor,
                                width: 0.1),
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
                                size: 18,
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
                          "Buy Airtime",
                          showBadge: false,
                          icon: Icons.send_to_mobile,
                          page: SelectedMobileCarrierPage(),
                        ),
                        _buildRow(
                          "Buy Data",
                          icon: Icons.system_update_alt,
                          showBadge: false,
                          page: SelectedDataRechargePage(),
                        ),
                      ],
                    )),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  iconColor: ColorConstants.white,
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.all(0),
                    childrenPadding: EdgeInsets.only(left: 20),
                    leading: Container(
                      height: 45,
                      width: 45,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: new BorderSide(
                              color: ColorConstants.whiteLighterColor,
                              width: 0.1),
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
                              Typicons.lightbulb,
                              size: 18,
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
                        "Pay Electricity Bill",
                        showBadge: false,
                        icon: Icons.electrical_services,
                        page: SelectedElectricitySubPage(),
                      ),
                      _buildRow(
                        "Pay Tv Subscription",
                        icon: Icons.tv,
                        showBadge: false,
                        page: SelectedCableTvPage(),
                      ),
                    ],
                  ),
                ),

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
                            side: new BorderSide(
                                color: ColorConstants.whiteLighterColor,
                                width: 0.1),
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
                                size: 18,
                                color: ColorConstants.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text('Settings',
                          style: TextStyle(
                            color: active,
                            fontSize: 14,
                          )),
                      children: <Widget>[
                        _buildRow(
                          "Accounts",
                          showBadge: false,
                          icon: Icons.food_bank_outlined,
                          page: AccountPage(),
                        ),
                        _buildRow(
                          "Security",
                          showBadge: false,
                          icon: Icons.security,
                          page: SecurityPage(),
                        ),
                      ],
                    )),
                // _buildRow(
                //   "Sell / Buy GiftCards",
                //   icon: Icons.card_giftcard,
                //
                //   openState: false,
                // ),
                _buildRow(
                  "Deposit / Withdrawal",
                  icon: Icons.dashboard_customize,
                  page: DepositWithdrawPage(
                    indexNum: 0,
                  ),
                ),
                // _buildRow(
                //   "Buy Social Media Likes",
                //   icon: Icons.money,
                //   showBadge: false,
                //   openState: false,
                // ),
                // _buildDivider(),

                _buildRow("Notifications",
                    icon: Icons.notifications, page: NotificationsPage()),
                _buildRow("Contact us",
                    icon: Icons.phone,
                    page: ContactUs(
                        cardColor: ColorConstants.primaryColor,
                        textColor: ColorConstants.secondaryColor,
                        //logo: AssetImage('assets/images/mbl2.png'),
                        email: 'mabro@gmail.com',
                        companyName: 'Mabro',
                        companyColor: ColorConstants.secondaryColor,
                        phoneNumber: '+917818044311',
                        website: 'https://google.com',
                        linkedinURL: 'Mabro',
                        tagLine: 'Mabro Contacts',
                        taglineColor: ColorConstants.secondaryColor,
                        twitterHandle: 'Mabro',
                        instagram: 'Mabro',
                        facebookHandle: 'Mabro')),
                _buildRow("FAQ", icon: Icons.info_outline, page: FAQPage()),
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
                        border: Border.all(
                            color: ColorConstants.whiteLighterColor,
                            width: 0.1)),
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

  Widget _buildRow(String title,
      {IconData icon,
      Widget page,
      bool isMethod = false,
      bool showBadge = true,
      bool openState = true}) {
    final TextStyle tStyle =
        TextStyle(color: active, fontSize: 14, fontWeight: FontWeight.normal);
    return GestureDetector(
      onTap: () => {
        Navigator.pop(context),
        (isMethod)
            ? _airtime2CashInfo()
            : (openState)
                ? kopenPage(context, page)
                : ShowSnackBar.showInSnackBar(
                    value: 'feature coming up soon!!!',
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    timer: 5)
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            height: 37,
            width: 37,
            child: Container(
              decoration: BoxDecoration(
                color: (showBadge)
                    ? ColorConstants.secondaryColor
                    : ColorConstants.transparent,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  icon,
                  size: 18,
                  color: ColorConstants.white,
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
      color: ColorConstants.primaryColor,
      height: 180,
      child: Card(
        color: ColorConstants.primaryColor,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              length: 2,
              indicatorSpace: 12.0,
              padding: EdgeInsets.only(bottom: 8),
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
            style: TextStyle(
                fontSize: 16, color: ColorConstants.whiteLighterColor),
          ),
        ),
      ],
    );
  }

  _userInfo() async {
    String message;
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response =
          await http.post(HttpService.rootUserInfo, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            bgColor: ColorConstants.secondaryColor,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        UserInfo userInfo = UserInfo.fromJson(body);

        bool status = userInfo.status;
        message = userInfo.message;

        if (status) {
          //String otp = userInfo.data.oTP;
          userId = userInfo.data.settings.user;
          if (userInfo.data.bvns == null) {
          } else {
            String firstName = userInfo.data.bvns.firstName.toString();
            String surName = userInfo.data.bvns.surname.toString();
            String bvn = userInfo.data.bvns.bvn.toString();

            SharedPrefrences.addStringToSP("bvn", bvn);
            SharedPrefrences.addStringToSP("first_name", firstName);
            SharedPrefrences.addStringToSP("surname", surName);
          }

          if (userInfo.data.account == null) {
          } else {
            String accountName = userInfo.data.account.accountName.toString();
            String accountNumber =
                userInfo.data.account.accountNumber.toString();
            String bankName = userInfo.data.account.bankName.toString();
            SharedPrefrences.addStringToSP("account_name", accountName);
            SharedPrefrences.addStringToSP("bank_name", bankName);
          }

          String emailTransactionNotification =
              userInfo.data.settings.emailTransactionNotification.toString();
          String smsNotification =
              userInfo.data.settings.smsNotification.toString();
          String twoFactorAuthentication =
              userInfo.data.settings.twoFactorAuthentication.toString();
          String fingerPrintLogin =
              userInfo.data.settings.fingerPrintLogin.toString();
          String newsletter = userInfo.data.settings.newsletter.toString();

          SharedPrefrences.addStringToSP("userId", userId);
          SharedPrefrences.addStringToSP("account_number", accountNumber);

          SharedPrefrences.addStringToSP("sms_notification", smsNotification);
          SharedPrefrences.addStringToSP(
              "email_transaction_notification", emailTransactionNotification);
          SharedPrefrences.addStringToSP(
              "two_factor_authentication", twoFactorAuthentication);
          print(twoFactorAuthentication.toString());
          SharedPrefrences.addStringToSP(
              "finger_print_login", fingerPrintLogin);
          SharedPrefrences.addStringToSP("newsletter", newsletter);
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  void getUserInfo() {
    Future.delayed(Duration(seconds: 2), () {
      _userInfo();
    });
  }

  void _airtime2CashInfo() async {
    String message;
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response =
          await http.post(HttpService.rootAirCashInfo, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            bgColor: ColorConstants.secondaryColor,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        AirtimeToCashInfo airtimeToCashInfo = AirtimeToCashInfo.fromJson(body);

        bool status = airtimeToCashInfo.status;
        message = airtimeToCashInfo.message;

        if (status) {
          kopenPage(
              context,
              AirtimeToCashPage(
                mtnTransfer: airtimeToCashInfo.data.mtnTransfer,
                mtnChangePin: airtimeToCashInfo.data.mtnChangePin,
                airtelChangePin: airtimeToCashInfo.data.airtelChangePin,
                airtelTransfer: airtimeToCashInfo.data.airtelTransfer,
                gloTransfer: airtimeToCashInfo.data.gloTransfer,
                gloChangePin: airtimeToCashInfo.data.gloChangePin,
                mobileChangePin: airtimeToCashInfo.data.mobileChangePin,
                mobileTransfer: airtimeToCashInfo.data.mobileTransfer,
              ));
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }

  _p2PUserInfo({int index, String image, String coinTitle}) async {
    String message;
    try {
      var map = Map<String, dynamic>();
      map['userId'] = userId;

      var response =
          await http.post(HttpService.rootP2PUserInfo, body: map, headers: {
        'Authorization': 'Bearer ' + HttpService.token,
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
            value: 'The connection has timed out, please try again!',
            bgColor: ColorConstants.secondaryColor,
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
        return null;
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        P2PExchangeDetails p2pExchangeDetails =
            P2PExchangeDetails.fromJson(body);

        bool status = p2pExchangeDetails.status;
        message = p2pExchangeDetails.message;

        if (status) {
          if (saleStatus == 'p2pBuy') {
            kopenPage(
                context,
                BtcP2PBuySell(
                  buyInputState: true,
                  buyingPrice:
                      p2pExchangeDetails.data[0].buyingPrice.toString(),
                  sellingPrice:
                      p2pExchangeDetails.data[0].sellingPrice.toString(),
                  usdBuyingPrice:
                      p2pExchangeDetails.data[0].usdBuyingPrice.toString(),
                  usdSellingPrice:
                      p2pExchangeDetails.data[0].usdSellingPrice.toString(),
                ));
          } else if (saleStatus == 'p2pSell') {
            kopenPage(
                context,
                BtcP2PBuySell(
                  sellInputState: true,
                  buyingPrice:
                      p2pExchangeDetails.data[0].buyingPrice.toString(),
                  sellingPrice:
                      p2pExchangeDetails.data[0].sellingPrice.toString(),
                  usdBuyingPrice:
                      p2pExchangeDetails.data[0].usdBuyingPrice.toString(),
                  usdSellingPrice:
                      p2pExchangeDetails.data[0].usdSellingPrice.toString(),
                ));
          } else if (saleStatus == 'exchange') {
            print(index - 1);
            kopenPage(
              context,
              CoinExchange(
                coinName: (index == 0)
                    ? coinList[index].title
                    : coinList[index - 1].title,
                buyingPrice:
                    p2pExchangeDetails.data[index - 1].buyingPrice.toString(),
                sellingPrice:
                    p2pExchangeDetails.data[index - 1].sellingPrice.toString(),
                usdBuyingPrice: p2pExchangeDetails
                    .data[index - 1].usdBuyingPrice
                    .toString(),
                usdSellingPrice: p2pExchangeDetails
                    .data[index - 1].usdSellingPrice
                    .toString(),
                coinImage: image,
                coinSign: coinTitle,
              ),
            );
          }
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }
}
