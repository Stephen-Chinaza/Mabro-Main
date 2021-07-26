import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/data_recharge_page/selected_data_recharge.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDataRecharge extends StatefulWidget {
  @override
  _SelectDataRechargeState createState() => _SelectDataRechargeState();
}

class _SelectDataRechargeState extends State<SelectDataRecharge> {
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
              title: 'Data Recharge',
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
                          textValue: 'Select Mobile Carrier *'),
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
                            hintText: 'Mobile Carrier',
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
          buttomSheetTitle: 'Data Recharge',
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
                      SelectedDataRechargePage(
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
            height: 70,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Container(
                  width: 60,
                  height: 60,
                  child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(image, width: 40, height: 40),
                      )),
                ),
                SizedBox(width: 40),
                TextStyles.textSubHeadings(
                  textSize: 14,
                  textColor: Colors.black54,
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
