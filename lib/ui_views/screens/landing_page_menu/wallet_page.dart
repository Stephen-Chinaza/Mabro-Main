
import 'package:intl/intl.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/screens/btc_p2p_pages/p2p_buy_sell_page.dart';
import 'package:mabro/ui_views/screens/deposit_and_withdraw_funds_page/deposit_withdraw.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  bool nairaState = true;
  bool dollarState = false;

  String nairaBalance = '';
  String dollarBalance = '';
  String btcBalance = '';
  var formatter = NumberFormat('#,##,000');

  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nairaBalance = (pref.getString('nairaBalance') ?? '');

    setState(() {
      nairaBalance = formatter.format(int.tryParse(nairaBalance));

    });
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: TopBar(
        title: 'Wallets',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    color:ColorConstants.primaryLighterColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Wallet Balance: ',
                                style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontSize: 18,
                                )),
                            GestureDetector(
                              onTap: (){
                                kopenPage(context,
                                  DepositWithdrawPage(indexNum: 0,),);
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    gradient: ColorConstants.primaryGradient),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Fund',
                                      style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text("NGN"+nairaBalance,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            )),
                        SizedBox(height: 15,),
                        _inputTextField(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/btc.jpg',
                    wallet_title: 'BTC',
                    color: Colors.red,
                    balance: '',
                    dollar_equivalent: '$nairaBalance',
                    icon: Icons.arrow_downward,
                    rise_or_fall: ''
                ),
                SizedBox(height: 8,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/ethereum.png',
                    wallet_title: 'Ethereum',
                    color: Colors.green,
                    balance: '',
                    dollar_equivalent: '$nairaBalance',
                    icon: Icons.arrow_upward,
                    rise_or_fall: ''
                ),
                SizedBox(height: 8,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/litecoin.png',
                    wallet_title: 'Lite Coin',
                    color: Colors.red,
                    balance: '',
                    dollar_equivalent: '$nairaBalance',
                    icon: Icons.arrow_downward,
                    rise_or_fall: ''
                ),
                SizedBox(height: 8,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/usdt.png',
                    wallet_title: 'USDT',
                    color: Colors.red,
                    balance: '',
                    dollar_equivalent: '',
                    icon: Icons.arrow_downward,
                    rise_or_fall: ''
                ),

                SizedBox(height: 20),
                _bottomButton(),
              ],),
          ),
        ),
      ),
    );
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: TextButton(
                  onPressed: () {
                    BtcP2PBuySell(buyInputState: true,);

                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      primary: Colors.white,
                      backgroundColor: Colors.green[900],
                      textStyle: const TextStyle(fontSize: 14),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(
                          color: Colors.green[900], width: 2)),
                  child: Text(
                    'Buy',
                    style: TextStyle(color: ColorConstants.white),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: CustomButton(
                disableButton: true,
                text: 'Sell',
                margin: 0,
                width: 140,
                onPressed: () {
                  BtcP2PBuySell(sellInputState: true,);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputTextField(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border:  Border.all(color: ColorConstants.whiteLighterColor, width: 0.5)
      ),
      child:
    TextField(
      keyboardType: TextInputType.text,
      controller: TextEditingController(text: 'Search'),
      cursorColor: ColorConstants.secondaryColor,
      style: TextStyle(color: ColorConstants.whiteLighterColor),
      decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: ColorConstants.primaryColor.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          prefixIcon:  Icon(
            Icons.search,
            color: ColorConstants.whiteLighterColor,
            size: 22,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.transparent, width: 0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.transparent),
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
              fontStyle: FontStyle.normal,
              color: ColorConstants.whiteLighterColor,
              fontSize: 16,
              fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
    ),
    );
  }



  Widget _cryptoWallets(
      {Size size,
        String wallet_title,
        String img_url,
        Color color,
        String dollar_equivalent,
        String rise_or_fall,
        IconData icon,
        String balance,
        Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 75,
        child: Card(
          color: ColorConstants.primaryLighterColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(img_url,
                          height: 25, width: 25),
                      SizedBox(width: 10,),
                      Text(
                        wallet_title,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                    ],
                  ),
                  Text(
                    'NGN'+dollar_equivalent,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
