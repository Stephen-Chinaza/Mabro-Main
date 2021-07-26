import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/tv_subscription_pages/selected_cable_tv.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectCableTvPage extends StatefulWidget {
  @override
  _SelectCableTvPageState createState() => _SelectCableTvPageState();
}

class _SelectCableTvPageState extends State<SelectCableTvPage> {
  List<ImageList> providerImages;

  @override
  void initState() {
    super.initState();
    providerImages = DemoData.images;
  }

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
              icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              title: 'Cable Tv',
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.textSubHeadings(
                          textColor: Colors.black87,
                          textSize: 13,
                          textValue: 'Select Tv Network *'),
                      SizedBox(height: 20),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent: _bottomSheetContent(context),
                            );
                          },
                          child: IconFields(
                            isEditable: false,
                            hintText: 'Tv Network',
                          ),
                        );
                      }),
                    ]),
              ),
            )),
      ],
    );
  }

  Widget _bottomSheetContent(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select Tv Network',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildDataList(),
        ]),
      ],
    );
  }

  Widget _buildDataList() {
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: providerImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                image: providerImages[i].image,
                title: providerImages[i].title,
                onTapped: () {
                   kbackBtn(context);
                  kopenPage(
                      context,
                      SelectedCableTvPage(
                          image: providerImages[i].image,
                          title: providerImages[i].title));
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
