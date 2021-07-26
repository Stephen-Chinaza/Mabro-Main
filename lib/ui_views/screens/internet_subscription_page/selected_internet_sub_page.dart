import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectedInternetSubsPage extends StatefulWidget {
  String image, title, amount;

  SelectedInternetSubsPage({Key key, this.image, this.title})
      : super(key: key);
  @override
  _SelectedInternetSubsPageState createState() =>
      _SelectedInternetSubsPageState();
}

class _SelectedInternetSubsPageState extends State<SelectedInternetSubsPage> {
  List<ImageList> providerImages;
  List<AirtimeList> rechargeAmount;
  bool checkState;

  TextEditingController rechargeAmountController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    providerImages = DemoData.images;
    rechargeAmount = DemoData.airtime;
    checkState = false;
  }

  void dispose() {
    rechargeAmountController.dispose();
    super.dispose();
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
            title: 'Internet Subcription',
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.center,
                   child:  Container(
                  width: 90,
                  height: 90,
                  child: Card(
                      elevation: 3,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(widget.image, width: 50, height: 50),
                      )),
                ),),
              SizedBox(height: 30),
              TextStyles.textSubHeadings(
                  textColor: Colors.black54,
                  textSize: 13,
                  textValue: 'Selected Mobile Carrier *'),
              SizedBox(height: 10),
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    buildShowBottomSheet(
                      context: context,
                      bottomsheetContent: _bottomSheetContentMobileCarrier(
                          context, widget.title, widget.image),
                    );
                  },
                  child: IconFields(
                    hintText: widget.title,
                    isEditable: false,
                    labelText: widget.title,
                  ),
                );
              }),
              
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(children: [
                      Icon(Icons.star),
                      SizedBox(width: 15),
                      TextStyles.textSubHeadings(
                          textColor: Colors.black54,
                          textSize: 11,
                          textValue: 'No Beneficiary available'),
                    ]),
                  )),
              SizedBox(height: 20),
              TextStyles.textSubHeadings(
                  textColor: Colors.black54,
                  textSize: 13,
                  textValue: 'User ID *'),
              SizedBox(height: 10),
              NormalFields(
                width: MediaQuery.of(context).size.width,
                hintText: 'Input User ID',
                labelText: '',
                onChanged: (name) {},
                controller: TextEditingController(text: ''),
              ),
               SizedBox(height: 20),
              TextStyles.textSubHeadings(
                  textColor: Colors.black54,
                  textSize: 13,
                  textValue: 'Select Data Volume *'),
              SizedBox(height: 10),
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    buildShowBottomSheet(
                      context: context,
                      bottomsheetContent:
                          _bottomSheetContentAirtimeAmount(context),
                    );
                  },
                  child: IconFields(
                    isEditable: false,
                    hintText: 'Select Data Volume',
                    labelText: '',
                    controller: rechargeAmountController,
                  ),
                );
              }),
              SizedBox(height: 5),
              TextStyles.textSubHeadings(
                  textColor: Colors.black54,
                  textSize: 10,
                  textValue: '20,220NGN available'),
              Row(
                children: [
                  Checkbox(
                      value: checkState,
                      onChanged: (state) {
                        setState(() {
                          checkState = state;
                        });
                      }),
                  Flexible(
                    child: TextStyles.textSubHeadings(
                        textColor: Colors.black54,
                        textSize: 11,
                        textValue: 'Save Beneficiary'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey.withOpacity(0.7),
                height: 0.5,
              ),
              SizedBox(height: 20),
              TextStyles.textSubHeadings(
                  textColor: Colors.black54, textSize: 13, textValue: 'Pin *'),
              SizedBox(height: 10),
              PasswordTextField(
                padding: 0,
                radius: 4.0,
                elevation: 1.0,
                textHint: 'Enter Your Pin',
                labelText: 'Enter Your Pin',
                onChanged: (name) {},
                controller: TextEditingController(text: ''),
              ),
              SizedBox(height: 5),
              TextStyles.textSubHeadings(
                  textColor: Colors.black54,
                  textSize: 10,
                  textValue: 'enter transaction pin for authorization'),
              SizedBox(height: 20),
              CustomButton(
                margin: 0,
                  disableButton: true, onPressed: () {}, text: 'Continue'),
            ]),
          )),
        ),
      ],
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
          buttomSheetTitle: 'Select Bouquet plan',
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

  Widget _bottomSheetContentAirtimeAmount(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select Airtime Amount',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildAirtimeList(
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
          itemCount: providerImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                image: providerImages[i].image,
                title: providerImages[i].title,
                onTapped: () {
                  setState(() {
                    widget.title = providerImages[i].title;
                    widget.image = providerImages[i].image;
                    kbackBtn(context);
                  });
                });
          }),
    );
  }

  Widget _buildAirtimeList(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
          itemCount: rechargeAmount.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildList(
                title: rechargeAmount[i].amount,
                onTapped: () {
                  setState(() {
                    rechargeAmountController.text = rechargeAmount[i].amount;
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

  Widget buildList({String title, String image, Function onTapped}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextStyles.textSubHeadings(
                  textSize: 14,
                  textColor: Colors.black54,
                  textValue: title,
                ),
              ),
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
