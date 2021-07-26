import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/giftcard_transactions_page.dart/giftcard_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BuySellGiftcardTran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TopBar(
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
            title: 'Giftcards'.toUpperCase(),
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/giftcard.jpg',
                      )),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  GiftcardBuySaleOption(
                      image: 'assets/images/giftcard.jpg', title: 'Buy Giftcard',widget: GiftCardListsPage(title: 'Buy Giftcard')),
                  GiftcardBuySaleOption(
                      image: 'assets/images/giftcard.jpg', title: 'Sale Giftcard',widget: GiftCardListsPage(title: 'Sale Giftcard')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GiftcardBuySaleOption extends StatelessWidget {
  final String title, image;
  final Widget widget;

  const GiftcardBuySaleOption({Key key, this.title, this.image, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => kopenPage(context, widget),
        child: Container(
          child: Card(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  child: Image.asset(
                    image,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                    child: Center(
                      child: Text(title.toUpperCase(),
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
      ),
    );
  }
}
