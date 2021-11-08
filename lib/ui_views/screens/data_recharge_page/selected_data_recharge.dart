import 'dart:convert';
import 'dart:io';

import 'package:flutter_contacts/contact.dart';
import 'package:intl/intl.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/buy_9mobile_bundle.dart';
import 'package:mabro/core/models/buy_airtel_bundle.dart';
import 'package:mabro/core/models/buy_airtime_bundle.dart';
import 'package:mabro/core/models/buy_glo_bundle.dart';
import 'package:mabro/core/models/buy_mtn_bundle.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/loading_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/screens/contact_page/contact_page.dart';
import 'package:mabro/ui_views/widgets/bottomsheets/bottomsheet.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/icon_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SelectedDataRechargePage extends StatefulWidget {
  String image, title, amount;
  final Contact contact;

  SelectedDataRechargePage(
      {Key key, this.image, this.title, this.contact = null})
      : super(key: key);
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
  String network, dataId;
  String userId;
  int maxLines = 1;

  var formatter = NumberFormat('#,##,000');
  Future<void> getBalance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    userId = (pref.getString('userId') ?? '');
    userPin = (pref.getString('lock_code') ?? '');
    nairaBalance = (pref.getString('nairaBalance') ?? '');

    setState(() {
      nairaBalance = formatter.format(int.tryParse(nairaBalance));
    });
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
    userId = '';
    getBalance();
    pageState = false;

    beneficiaries = [
      'Emeka Ofor',
      'Okezie Ikeazu',
      'Nnamdi Kanu',
      'Chinwetalu Okolie'
    ];
    checkState = true;
    _selectedIndex = 0;

    if (widget.contact == null) {
      _phoneController.text = '';
    } else {
      _phoneController.text = widget.contact.phones.isNotEmpty
          ? widget.contact.phones.first.number
          : '(none)';
    }
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
                backgroundColor: ColorConstants.primaryColor,
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
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      elevation: 3,
                      color: ColorConstants.primaryLighterColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              // Builder(builder: (context) {
                              //   return GestureDetector(
                              //     onTap: () {
                              //       buildShowBottomSheet(
                              //         context: context,
                              //         bottomsheetContent:
                              //             _bottomSheetContentMobileCarrier(
                              //           context,
                              //         ),
                              //       );
                              //     },
                              //     child: IconFields(
                              //       hintText: 'Select Beneficiary',
                              //       isEditable: false,
                              //       labelText: widget.title,
                              //       controller: _beneficiaryController,
                              //     ),
                              //   );
                              // }),
                              // SizedBox(height: 20),
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
                                  SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        kopenPage(
                                            context,
                                            Contacts(
                                              pageTitle: 'data',
                                            ));
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.contact_phone,
                                          size: 40,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Text('Select Network',
                                  style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 16)),
                              SizedBox(height: 10),

                              Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: providerImages.length,
                                    scrollDirection: Axis.horizontal,
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
                                            color: providerImages[i].color,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  border: Border.all(
                                                    color: _selectedIndex !=
                                                                null &&
                                                            _selectedIndex == i
                                                        ? Colors
                                                            .deepPurpleAccent
                                                        : Colors.transparent,
                                                    width: 2,
                                                  ),
                                                ),
                                                height: 63,
                                                width: 75,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
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
                                          _bottomSheetContentData(
                                        context,
                                      ),
                                    );
                                  },
                                  child: IconFields(
                                    hintText: 'Select data bundle',
                                    isEditable: false,
                                    maxLines: maxLines,
                                    labelText: widget.title,
                                    controller: _bundleController,
                                    onChanged: (String i) {
                                      if (_bundleController.text != '') {
                                        print(i.length.toString() +
                                            'qwwwwwwwwwwwwwagewewgggegeweew');
                                        setState(() {
                                          maxLines = 2;
                                        });
                                      }
                                    },
                                  ),
                                );
                              }),
                              SizedBox(height: 5),
                              Text('balance: ' + nairaBalance + 'NGN' ?? '',
                                  style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 12)),
                              // SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     SizedBox(
                              //       height: 20,
                              //       width: 20,
                              //       child: Checkbox(
                              //           value: checkState,
                              //           checkColor: ColorConstants.white,
                              //           focusColor: ColorConstants.secondaryColor,
                              //           activeColor:
                              //               ColorConstants.secondaryColor,
                              //           onChanged: (state) {
                              //             setState(() {
                              //               checkState = state;
                              //             });
                              //           }),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Flexible(
                              //       child: Text('Save Beneficiary',
                              //           style: TextStyle(
                              //               fontWeight: FontWeight.w800,
                              //               color: ColorConstants.whiteLighterColor,
                              //               fontSize: 14)),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 10),
                              Divider(color: ColorConstants.whiteLighterColor),
                              SizedBox(height: 10),
                              PasswordTextField(
                                icon: Icons.lock_open,
                                textHint: 'Enter pin',
                                controller: _pinController,
                                textInputType: TextInputType.number,
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
                                    onPressed: () {
                                      buyDataBundles();
                                    },
                                    text: 'Buy data now'),
                              ),
                              SizedBox(height: 30),
                            ]),
                      ),
                    ),
                  ),
                )),
              ),
            ],
          );
  }

  Widget _bottomSheetContentData(
    BuildContext context,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BottomSheetHeader(
        buttomSheetTitle: 'Select Data Plan'.toUpperCase(),
      ),
      SizedBox(height: 6),
      Expanded(child: _buildDataPlan()),
    ]);
  }

  Widget _buildDataPlan() {
    if (network == 'mtn') {
      return FutureBuilder(
        future: HttpService.dataMtnPlanList(
            context, userId, 'https://mabro.ng/dev/_app/mobile-data/plans/mtn'),
        builder: (BuildContext context, AsyncSnapshot<dataMtnList> snapshot) {
          dataMtnList mtnData = snapshot.data;
          if (snapshot.hasData) {
            if (mtnData.data.mtn.length == 0) {
              return Container();
            } else {
              return Container(
                child: ListView.builder(
                    itemCount: mtnData.data.mtn.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return buildListTile(
                          title: mtnData.data.mtn[i].dataName,
                          onTapped: () {
                            setState(() {
                              _bundleController.text =
                                  mtnData.data.mtn[i].dataName;
                              dataId = mtnData.data.mtn[i].dataId;
                              kbackBtn(context);
                            });
                          });
                    }),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to load',
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.whiteLighterColor),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
            ));
          }
        },
      );
    } else if (network == 'airtel') {
      return FutureBuilder(
        future: HttpService.dataAirtelPlanList(context, userId,
            'https://mabro.ng/dev/_app/mobile-data/plans/airtel'),
        builder:
            (BuildContext context, AsyncSnapshot<dataAirtelList> snapshot) {
          dataAirtelList airtelData = snapshot.data;

          if (snapshot.hasData) {
            if (airtelData.data.airtel.length == 0) {
              return Container();
            } else {
              return Container(
                child: ListView.builder(
                    itemCount: airtelData.data.airtel.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return buildListTile(
                          title: airtelData.data.airtel[i].dataName,
                          onTapped: () {
                            setState(() {
                              _bundleController.text =
                                  airtelData.data.airtel[i].dataName;
                              dataId = airtelData.data.airtel[i].dataId;

                              kbackBtn(context);
                            });
                          });
                    }),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Network error',
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.whiteLighterColor),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
            ));
          }
        },
      );
    } else if (network == 'glo') {
      return FutureBuilder(
        future: HttpService.dataGloPlanList(
            context, userId, 'https://mabro.ng/dev/_app/mobile-data/plans/glo'),
        builder: (BuildContext context, AsyncSnapshot<dataGloList> snapshot) {
          dataGloList gloData = snapshot.data;

          if (snapshot.hasData) {
            if (gloData.data.glo.length == 0) {
              return Container();
            } else {
              return Container(
                child: ListView.builder(
                    itemCount: gloData.data.glo.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return buildListTile(
                          title: gloData.data.glo[i].dataName,
                          onTapped: () {
                            setState(() {
                              _bundleController.text =
                                  gloData.data.glo[i].dataName;
                              dataId = gloData.data.glo[i].dataId;
                              kbackBtn(context);
                            });
                          });
                    }),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Network error',
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.whiteLighterColor),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
            ));
          }
        },
      );
    } else if (network == '9mobile') {
      return FutureBuilder(
        future: HttpService.data9mobilePlanList(context, userId,
            'https://mabro.ng/dev/_app/mobile-data/plans/9mobile'),
        builder:
            (BuildContext context, AsyncSnapshot<data9mobileList> snapshot) {
          data9mobileList mobileData = snapshot.data;

          if (snapshot.hasData) {
            if (mobileData.data.mobile.length == 0) {
              return Container();
            } else {
              return Container(
                child: ListView.builder(
                    itemCount: mobileData.data.mobile.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return buildListTile(
                          title: mobileData.data.mobile[i].dataName,
                          onTapped: () {
                            setState(() {
                              _bundleController.text =
                                  mobileData.data.mobile[i].dataName;
                              dataId = mobileData.data.mobile[i].dataId;

                              kbackBtn(context);
                            });
                          });
                    }),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Network error',
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.whiteLighterColor),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
            ));
          }
        },
      );
    }
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
            color: ColorConstants.primaryColor,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(8),
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.whiteLighterColor,
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
                child: TextStyles.textDetails(
                  textSize: 14,
                  textColor: Colors.black54,
                  textValue: title,
                ),
              ),
            ),
          ),
        ),
        Divider(color: ColorConstants.whiteLighterColor),
      ],
    );
  }

  void buyDataBundles() async {
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
        map['userId'] = userId;
        map['network'] = network;
        map['phone_number'] = _phoneController.text;
        map['data_id'] = dataId;

        var response =
            await http.post(HttpService.rootBuyData, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
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

          BuyAirtimeBundle data = BuyAirtimeBundle.fromJson(body);

          bool status = data.status;
          String message = data.message;
          if (status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                iconData: Icons.check_circle,
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
            String balance = data.data.balance.toString();

            SharedPrefrences.addStringToSP("nairaBalance", balance);

            _phoneController.text = '';
            _bundleController.text = '';
            _pinController.text = '';
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
