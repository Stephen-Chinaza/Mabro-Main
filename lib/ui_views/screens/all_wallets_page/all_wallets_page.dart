import 'package:flushbar/flushbar.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/screens/deposit_and_withdraw_funds_page/deposit_withdraw.dart';
import 'package:mabro/ui_views/screens/recieve_btc_page/recieve_btc_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllWalletPage extends StatefulWidget {
  @override
  _AllWalletPageState createState() => _AllWalletPageState();
}

class _AllWalletPageState extends State<AllWalletPage> {
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
      body: Container(
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
              _cryptoWallets()
            ],),
        ),
      ),
    );
  }

  Widget _inputTextField(){
    return Container(child:
    TextField(
      keyboardType: TextInputType.text,
      controller: TextEditingController(text: ''),
      cursorColor: ColorConstants.secondaryColor,
      style: TextStyle(color: ColorConstants.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.whiteColor, width: 1.0),
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
          color: Colors.white,
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
        Function onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey.shade200,
                  offset: Offset(3, 3))
            ],
            border: Border.all(
                color: Colors.grey.shade200, // Set border color
                width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BTC Wallet',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Image.asset('assets/images/btc.jpg',
                          height: 25, width: 25)
                    ],
                  ),
                  Divider(),
                  Text(
                    'Balance',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        btcBalance,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        '\$10.545',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NGN 24,000.00',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        '+ 2.09',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Colors.green.shade900,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
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
