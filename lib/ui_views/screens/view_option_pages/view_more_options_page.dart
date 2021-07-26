import 'dart:io';

import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        title: 'All Menu',
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          allOption(),
        ],
      ),
    );
  }

  SliverGrid allOption() {
    List<HomeMenu> subList = DemoData.menu;
    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Material(
                  elevation: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Icon(subList[index].icon, color: ColorConstants.primaryColor),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          color: ColorConstants.transparent,
                          child: Center(
                            child: Text(subList[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.headline6.merge(
                                          TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
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
        },
        childCount: subList.length,
      ),
    );
  }
}
