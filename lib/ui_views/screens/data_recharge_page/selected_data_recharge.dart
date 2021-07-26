import 'dart:convert';
import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/buy_airtime_bundle.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:mabro/ui_views/commons/show_phone_contact/contacts_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SelectedDataRechargePage extends StatefulWidget {
  String image, title, amount;

  SelectedDataRechargePage({Key key, this.image, this.title}) : super(key: key);
  @override
  _SelectedDataRechargePageState createState() =>
      _SelectedDataRechargePageState();
}

class _SelectedDataRechargePageState extends State<SelectedDataRechargePage> {
  List<ImageList> providerImages;
  List<AirtimeList> rechargeAmount;
  bool checkState;
  String _password;
  bool pageState;
  String nairaBalance;
  String userPin;

  List<String> beneficiaries;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _beneficiaryController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _bundleController = new TextEditingController();

  int _selectedIndex;
  String network;
  String user;

  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nairaBalance = (pref.getString('naria_balance') ?? '');
    user = (pref.getString('user') ?? '');
    userPin = (pref.getString('lock_code') ?? '');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    providerImages = DemoData.images;
    rechargeAmount = DemoData.airtime;
    _password = '';

    network = 'mtn';
    userPin = '';
    nairaBalance = '';
    user = '';
    getBalance();
    pageState = false;

    beneficiaries = [
      'Emeka Ofor',
      'Okezie Ikeazu',
      'Nnamdi Kanu',
      'Chinwetalu Okolie'
    ];
    checkState = false;
    _selectedIndex = 0;
  }

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void dispose() {
    _beneficiaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (pageState)
        ? loadingPage(state: pageState)
        : Stack(
            children: [
              buildFirstContainer(),
              buildSecondContainer(),
              Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.white,
                appBar: TopBar(
                  backgroundColorStart: ColorConstants.primaryColor,
                  backgroundColorEnd: ColorConstants.secondaryColor,
                  icon:
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  title: 'Buy Data',
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
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount: providerImages.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.all(4.0),
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        _onSelected(i);

                                        setState(() {
                                          switch (i) {
                                            case 0:
                                              network = 'mtn';
                                              break;
                                            case 1:
                                              network = 'glo';
                                              break;
                                            case 2:
                                              network = 'airtel';
                                              break;
                                            case 3:
                                              network = '9mobile';
                                              break;
                                            default:
                                              network = 'mtn';
                                          }
                                        });
                                      },
                                      child: Card(
                                          elevation: 3,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                border: Border.all(
                                                  color: _selectedIndex !=
                                                              null &&
                                                          _selectedIndex == i
                                                      ? Colors.redAccent
                                                      : Colors.transparent,
                                                  width: 2,
                                                ),
                                              ),
                                              height: 80,
                                              width: 80,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    providerImages[i].image),
                                              ))),
                                    );
                                  }),
                            ),
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
                                  hintText: 'Select data bundle',
                                  isEditable: false,
                                  labelText: widget.title,
                                ),
                              );
                            }),
                            SizedBox(height: 5),
                            Text('Balance: NGN 0',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 12)),
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
                                      activeColor:
                                          ColorConstants.secondaryColor,
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
                              controller: _pinController,
                              labelText: 'Enter pin',
                              onChanged: (password) {
                                _password = password;
                              },
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
                                  text: 'Buy data now'),
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

  void buyAirtime() async {
    if (_phoneController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'Enter phone number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_bundleController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.primaryColor,
          value: 'Select data bundle',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_pinController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter transaction pin',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else if (userPin != _pinController.text) {
      ShowSnackBar.showInSnackBar(
          value: 'Invalid pin entered',
          context: context,
          scaffoldKey: _scaffoldKey);
    } else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['user'] = user;
        map['network'] = network;
        map['phone_number'] = _phoneController.text;
        map['amount'] = _bundleController.text;

        var response = await http
            .post(HttpService.rootBuyAirtime, body: map)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: 'The connection has timed out, please try again!',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
          return null;
        });

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          BuyAirtimeBundle regUser = BuyAirtimeBundle.fromJson(body);

          bool status = regUser.status;
          String message = regUser.message;
          if (status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          } else if (!status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                bgColor: ColorConstants.primaryColor,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.primaryColor,
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.primaryColor,
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void cPageState({bool state = false}) {
    setState(() {
      pageState = state;
    });
  }
}
