import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class BuySingleGiftcards extends StatefulWidget {
  String image, title;

  BuySingleGiftcards({Key key, this.image, this.title}) : super(key: key);
  @override
  _BuySingleGiftcardsState createState() => _BuySingleGiftcardsState();
}

class _BuySingleGiftcardsState extends State<BuySingleGiftcards> {
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
            title: widget.title + ' GiftCard',
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyles.textHeadings(
                    textSize: 14,
                    textColor: Colors.black,
                    textValue: 'Selected GiftCard',
                  ),
                  SizedBox(height: 12),
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        buildShowBottomSheet(
                          context: context,
                          bottomsheetContent: _bottomSheetContentMobileCarrier(
                              context, widget.title, widget.image),
                        );
                      },
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 2.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  widget.image,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                TextStyles.textHeadings(
                                  textSize: 14,
                                  textColor: Colors.black,
                                  textValue: widget.title,
                                ),
                                Icon(Icons.arrow_forward_ios_sharp,
                                    size: 18, color: Colors.black),
                              ],
                            ),
                          )),
                    );
                  }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStyles.textHeadings(
                        textSize: 14,
                        textColor: Colors.black,
                        textValue: 'Select Country',
                      ),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent:
                                  _bottomSheetContentMobileCarrier(
                                      context, widget.title, widget.image),
                            );
                          },
                          child: TextStyles.textHeadings(
                            textSize: 12,
                            textColor: Colors.black,
                            textValue: 'View more >> ',
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildCountryContainer(
                      image: FontAwesomeIcons.flagUsa,
                      title: 'USA',
                      itemCount: 2),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomButton(
              disableButton: false,
              onPressed: () {
                //_buildShowBottomSheet(context);
              },
              text: 'Upload Image'),
        ),
      ],
    );
  }

  Widget _buildCountryContainer({IconData image, String title, int itemCount}) {
    return Container(
      height: 90,
      child: ListView.builder(
          itemCount: itemCount,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                height: 80,
                width: 100,
                child: Card(
                  margin: EdgeInsets.only(right: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Icon(
                          image,
                        ),
                      ),
                      Container(
                        width: 100,
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                          child: Center(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _bottomSheetContentMobileCarrier(
    BuildContext context,
    String title,
    String image,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select GiftCard',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildCarrierList(
            context,
          ),
        ]),
      ],
    );
  }

  Widget _buildCarrierList(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                image: widget.image,
                title: widget.title,
                onTapped: () {
                  setState(() {
                    widget.title = widget.title;
                    widget.image = widget.image;
                    kbackBtn(context);
                  });
                });
          }),
    );
  }

  Widget buildListTile({String title, String image, Function onTapped}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Image.asset(image, width: 40, height: 40),
                SizedBox(width: 40),
                TextStyles.textSubHeadings(
                  textSize: 12,
                  textColor: Colors.black87,
                  textValue: title,
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.7),
          height: 0.5,
        ),
      ],
    );
  }
}
