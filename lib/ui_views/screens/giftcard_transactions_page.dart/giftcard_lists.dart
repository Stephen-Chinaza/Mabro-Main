

import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/giftcard_transactions_page.dart/sell_single_giftcard_page.dart';
import 'package:mabro/ui_views/screens/giftcard_transactions_page.dart/buy_single_giftcard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GiftCardListsPage extends StatelessWidget {
   String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   GiftCardListsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
      appBar: TopBar(
              backgroundColorStart: ColorConstants.primaryColor,
              backgroundColorEnd: ColorConstants.secondaryColor,
              icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              title: title,
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),

            body: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          menuOption(context, _scaffoldKey),
        ],
            ),
            
    );
  }

  SliverGrid menuOption(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    List<HomeMenu> subList = DemoData.menu;
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 130;
    var _aspectRatio = _width / cellHeight;

    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _crossAxisCount,
        childAspectRatio: _aspectRatio,),
          
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              (title == 'Sale Giftcard') ?
              kopenPage(context, SellSingleGiftcards(image: 'assets/images/giftcard.jpg',title: 'Amazon',)):
              kopenPage(context, BuySingleGiftcards(image: 'assets/images/giftcard.jpg',title: 'Amazon',));
            },
            child: Container(
          child: Card(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  child: Image.asset(
                    'assets/images/giftcard.jpg',
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                    child: Center(
                      child: Text('Amazon'.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(fontSize: 12.0, color: Colors.black),
                              )),
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
}