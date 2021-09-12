import 'package:flushbar/flushbar.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/screens/deposit_and_withdraw_funds_page/deposit_withdraw.dart';
import 'package:mabro/ui_views/screens/recieve_btc_page/recieve_btc_page.dart';
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

  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nairaBalance = (pref.getString('naria_balance') ?? '');
    btcBalance = (pref.getString('bitcoin_balance') ?? '');

    setState(() {});
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 15,),
              Text('Balance: ',
                  style: TextStyle(
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14,
                  )),
              SizedBox(height: 15,),
              Text('\$15 476.88',
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 18,
                  )),
                SizedBox(height: 10,),
                Text('NGN 52,000.00 ',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    )),
                SizedBox(height: 15,),
                _inputTextField(),
                SizedBox(height: 15,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/btc.jpg',
                    wallet_title: 'BTC',
                    color: Colors.red,
                    balance: '0.0008976',
                    dollar_equivalent: '\$1 475.09',
                    icon: Icons.arrow_downward,
                  rise_or_fall: '-3.23'
                ),
                SizedBox(height: 8,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/ethereum.png',
                    wallet_title: 'Ethereum',
                    color: Colors.green,
                    balance: '0.0002376',
                    dollar_equivalent: '\$1 567.09',
                    icon: Icons.arrow_upward,
                    rise_or_fall: '0.23'
                ),
                SizedBox(height: 8,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/litecoin.png',
                    wallet_title: 'Lite Coin',
                    color: Colors.red,
                    balance: '0.000336',
                    dollar_equivalent: '\$1 444.09',
                    icon: Icons.arrow_downward,
                    rise_or_fall: '-3.211'
                ),
                SizedBox(height: 8,),
                _cryptoWallets(size: size,
                    img_url: 'assets/images/usdt.png',
                    wallet_title: 'USDT',
                    color: Colors.red,
                    balance: '0.000876',
                    dollar_equivalent: '\$1 999.09',
                    icon: Icons.arrow_downward,
                    rise_or_fall: '+3.23'
                ),
            ],),
          ),
        ),
      ),
    );
  }

  Widget _inputTextField(){
    return Container(child:
    TextField(
      keyboardType: TextInputType.text,
      controller: TextEditingController(text: 'Search'),
      cursorColor: ColorConstants.secondaryColor,
      style: TextStyle(color: ColorConstants.whiteLighterColor),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:  BorderSide(color: ColorConstants.transparent, width: 1.0),
        ),
        hintText: '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.whiteLighterColor, width: 0.2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.whiteLighterColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        prefixIcon:  Icon(
          Icons.search,
          color: ColorConstants.whiteLighterColor,
          size: 22,
        ),
        hintStyle: TextStyle(
            fontStyle: FontStyle.normal,
            color: ColorConstants.whiteLighterColor,
            fontSize: 16,
            fontWeight: FontWeight.w300),
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
      ),
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
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(img_url,
                          height: 25, width: 25),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          Text(
                            balance,
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: ColorConstants.whiteLighterColor,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),

                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        dollar_equivalent,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Row(
                        children: [
                          Text(
                            rise_or_fall,
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: color,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Icon(icon, color: color,size: 12)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
