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
import 'package:mabro/ui_views/commons/show_phone_contact/contacts_page.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SelectedElectricitySubPage extends StatefulWidget {
  String image, title, amount;

  SelectedElectricitySubPage({Key key, this.image, this.title})
      : super(key: key);
  @override
  _SelectedElectricitySubPageState createState() =>
      _SelectedElectricitySubPageState();
}

class _SelectedElectricitySubPageState
    extends State<SelectedElectricitySubPage> {
  List<ImageList> providerImages;
  List<AirtimeList> rechargeAmount;
  bool checkState;
  List<String> beneficiaries;
  String electName, electLogo;

  String user, nairaBalance;

  TextEditingController _beneficiaryController = new TextEditingController();
  TextEditingController _searchQueryController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    user = (pref.getString('user') ?? '');
    nairaBalance = (pref.getString('naria_balance') ?? '');

    setState(() {});
  }

  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    getData();
    providerImages = DemoData.electricityImages;
    rechargeAmount = DemoData.airtime;

    electName = 'Eko Electricity Distribution Company';
    electLogo = 'assets/images/ekoelect.jpg';

    beneficiaries = [
      'Emeka Ofor',
      'Okezie Ikeazu',
      'Nnamdi Kanu',
      'Chinwetalu Okolie'
    ];
    checkState = false;
    _selectedIndex = 0;
  }

  void dispose() {
    _beneficiaryController.dispose();
    _searchQueryController.dispose();
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
            title: 'Electricity bills',
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent:
                                  _bottomSheetContentSubscriptionTypes(
                                context,
                              ),
                            );
                          },
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(
                                    color: ColorConstants.lighterSecondaryColor
                                        .withOpacity(0.3),
                                    width: 0.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(electLogo,
                                          height: 40, width: 40),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(electName,
                                          style: TextStyle(
                                              color:
                                                  ColorConstants.secondaryColor,
                                              fontSize: 12)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 35),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent:
                                  _bottomSheetContentMobileCarrier(
                                context,
                              ),
                            );
                          },
                          child: IconFields(
                            hintText: 'Select Beneficiary',
                            isEditable: false,
                            labelText: widget.title,
                            controller: _beneficiaryController,
                          ),
                        );
                      }),
                      SizedBox(height: 20),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            buildShowBottomSheet(
                              context: context,
                              bottomsheetContent:
                                  _bottomSheetContentMobileCarrier(
                                context,
                              ),
                            );
                          },
                          child: IconFields(
                            hintText: 'Select meter type',
                            isEditable: false,
                            labelText: widget.title,
                          ),
                        );
                      }),
                      SizedBox(height: 20),
                      NormalFields(
                        width: MediaQuery.of(context).size.width,
                        hintText: 'Meter number',
                        labelText: '',
                        onChanged: (name) {},
                        controller: TextEditingController(text: ''),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: NormalFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: 'Phone number',
                              labelText: '',
                              onChanged: (name) {},
                              textInputType: TextInputType.number,
                              controller: _phoneController,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                kopenPage(context, ContactsPage());
                              },
                              child: Container(
                                child: Icon(
                                  Icons.contact_phone,
                                  size: 32,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      NormalFields(
                        width: MediaQuery.of(context).size.width,
                        hintText: 'Enter Amount',
                        labelText: '',
                        onChanged: (name) {},
                        controller: TextEditingController(text: ''),
                      ),
                      SizedBox(height: 5),
                      Text('Balance: NGN $nairaBalance',
                          style: TextStyle(color: Colors.orange, fontSize: 14)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                                value: checkState,
                                checkColor: ColorConstants.white,
                                focusColor: ColorConstants.secondaryColor,
                                activeColor: ColorConstants.secondaryColor,
                                onChanged: (state) {
                                  setState(() {
                                    checkState = state;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text('Save Beneficiary',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: ColorConstants.secondaryColor,
                                    fontSize: 14)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                      Divider(
                          color: ColorConstants.lighterSecondaryColor
                              .withOpacity(0.3)),
                      SizedBox(height: 20),
                      PasswordTextField(
                        icon: Icons.lock_open,
                        textHint: 'Enter pin',
                        controller: TextEditingController(text: ''),
                        labelText: 'Enter pin',
                        onChanged: (password) {},
                      ),
                      SizedBox(height: 5),
                      Text('Enter transaction pin for authorization',
                          style: TextStyle(
                              color: ColorConstants.secondaryColor,
                              fontSize: 12)),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                            margin: 0,
                            height: 40,
                            disableButton: true,
                            onPressed: () {},
                            text: 'Pay subscription now'),
                      ),
                      SizedBox(height: 30),
                    ]),
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _bottomSheetContentMobileCarrier(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select Beneficiary',
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
      child: ListView.builder(
          itemCount: providerImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                title: beneficiaries[i],
                onTapped: () {
                  setState(() {
                    _beneficiaryController.text = beneficiaries[i];
                    kbackBtn(context);
                  });
                });
          }),
    );
  }

  Widget buildListTile({String title, Function onTapped}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.secondaryColor,
                    fontSize: 14)),
          ),
        ),
        Divider(color: ColorConstants.lighterSecondaryColor),
      ],
    );
  }

  Widget buildList({String title, Function onTapped}) {
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
        Divider(color: ColorConstants.lighterSecondaryColor),
      ],
    );
  }

  Widget _bottomSheetContentSubscriptionTypes(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select Beneficiary',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildSubscriptionTypes(
            context,
          ),
        ]),
      ],
    );
  }

  Widget _buildSubscriptionTypes(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: providerImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildSubscriptionTypes(
                title: providerImages[i].title,
                image: providerImages[i].image,
                onTapped: () {
                  setState(() {
                    electName = providerImages[i].title;
                    electLogo = providerImages[i].image;
                    kbackBtn(context);
                  });
                });
          }),
    );
  }

  Widget buildSubscriptionTypes(
      {String title, String image, Function onTapped}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.secondaryColor,
                        fontSize: 10)),
              ],
            ),
          ),
        ),
        Divider(
          color: ColorConstants.lighterSecondaryColor,
          height: 0,
        ),
      ],
    );
  }
}
