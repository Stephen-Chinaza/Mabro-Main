import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/airtime_page/select_mobile_carrier.dart';
import 'package:mabro/ui_views/screens/data_recharge_page/select_data_recharge.dart';
import 'package:mabro/ui_views/screens/education_page/select_education_sub.dart';
import 'package:mabro/ui_views/screens/electricity_page/select_electricity_page.dart';
import 'package:mabro/ui_views/screens/tv_subscription_pages/select_cable_tv.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TopBar(
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
            title: 'Subscriptions',
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              subscriptionOption(context),
            ],
          ),
        ),
      ],
    );
  }

  SliverGrid subscriptionOption(BuildContext context) {
    List<HomeMenu> subList = DemoData.subs;

    int checkedItem = 0;

    List<Widget> menuScreens = [
      SelectDataRecharge(),
      SelectMobileCarrier(),
      SelectCableTvPage(),
      SelectElectricitySubPage(),
      SelectEducationSubPage(),
    ];

    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 3;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 120;
    var _aspectRatio = _width / cellHeight;

    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _crossAxisCount,childAspectRatio: _aspectRatio,),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {

          return GestureDetector(
            onTap: () {
              checkedItem = index;
              kopenPage(context, menuScreens[checkedItem]);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(subList[index].icon,
                        size: 30, color: selectedColour(index)),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        color: ColorConstants.transparent,
                        child: Center(
                          child: TextStyles.textSubHeadings(
                            centerText: true,
                            textSize: 10,
                            textColor: selectedColour(index),
                            textValue: subList[index].title.toUpperCase(),
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

  Color selectedColour(int position) {
    Color c;
    if (position % 3 == 0) c = Colors.red;
    if (position % 3 == 1) c = Colors.orange;
    if (position % 3 == 2) c = Colors.purple;
    if (position % 3 == 3) c = Colors.purple;
    if (position % 3 == 4) c = Colors.orange;
    if (position % 3 == 5) c = Colors.purple;
    if (position % 3 == 7) c = Colors.orange;

    return c;
  }
}
