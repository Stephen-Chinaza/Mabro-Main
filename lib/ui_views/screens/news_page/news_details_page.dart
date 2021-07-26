import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

class NewDetailsPage extends StatelessWidget {
  final String image;
  final String title;
  final String details;

  const NewDetailsPage({Key key, this.image, this.title, this.details})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'News Details',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(title,
                style: TextStyle(
                    color: ColorConstants.secondaryColor, fontSize: 16)),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(details,
                style: TextStyle(
                    color: ColorConstants.secondaryColor, fontSize: 11)),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
