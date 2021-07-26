import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

import 'news_details_page.dart';

class NewsUpdatePage extends StatefulWidget {
  @override
  _NewsUpdatePageState createState() => _NewsUpdatePageState();
}

class _NewsUpdatePageState extends State<NewsUpdatePage> {
  List<CoinList> newsData = [
    CoinList(
      image: 'assets/images/crypto1.jpg',
      title: "Elon Musk says prices 'seem high' after Bitcoin hits new high ",
      subtitle:
          'The leading cryptocurrency reached an all-time high on \$57,492 in the past 24 hours, showed the data',
      rise: '24/03/2021',
    ),
    CoinList(
      image: 'assets/images/crypto2.jpg',
      title:
          "Digital artwork which exists as JPG file sold for Rs 501 crore - Who's the artist behind it? ",
      subtitle:
          'The work, called "Everydays: The First 5000 Days" is a collage of \$5,000 individual images, which were made one-per-day over more than thirteen years.',
      rise: '2/03/2021',
    ),
    CoinList(
      image: 'assets/images/crypto3.jpg',
      title:
          "Time heals all wounds': Stefan Thomas loses password to Bitcoin worth \$220 million, makes 'peace with loss'  ",
      subtitle:
          "Despite Thomas Bitcoin wealth, he forgot his password and he has already made eight unsuccessful attempts to unlock the encryption device.",
      rise: '21/04/2021',
    ),
    CoinList(
      image: 'assets/images/crypto4.jpg',
      title: "Understanding the Concept of Cryptocurrency ",
      subtitle:
          'You might be familiar with the names Bitcoin and Ethereum, but do you really know that these names can be used as a mode of exchange in everyday life? The tempting idea of becoming rich overnight might have crossed your mind often. And cryptocurrency gives you freedom to get benefit from it. ',
      rise: '22/04/2021',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        backgroundColorStart: ColorConstants.primaryColor,
        backgroundColorEnd: ColorConstants.secondaryColor,
        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        title: 'Crypto News',
        onPressed: null,
        textColor: Colors.white,
        iconColor: Colors.white,
      ),
      body: buildListView(),
    );
  }

  Widget buildListView() {
    return ListView.builder(
        itemCount: newsData.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return _buildNewsCard(newsData[i].image, newsData[i].title,
              newsData[i].rise, newsData[i].subtitle, onTap: () {
            kopenPage(
                context,
                NewDetailsPage(
                  image: newsData[i].image,
                  title: newsData[i].title,
                  details: newsData[i].subtitle,
                ));
          });
        });
  }

  Widget _buildNewsCard(String image, String title, String date, String details,
      {Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(title ?? '',
                style: TextStyle(
                    color: ColorConstants.secondaryColor, fontSize: 16)),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(date ?? '',
                style: TextStyle(
                    color: ColorConstants.secondaryColor, fontSize: 11)),
          ),
          SizedBox(height: 5),
        ]),
      ),
    );
  }
}
