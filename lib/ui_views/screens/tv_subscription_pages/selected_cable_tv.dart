import 'dart:convert';
import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/buy_airtime_bundle.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/models/electricity_data_companies.dart';
import 'package:mabro/core/models/tv_data_companies/dstv.dart';
import 'package:mabro/core/models/tv_data_companies/gotv.dart';
import 'package:mabro/core/models/tv_data_companies/startimes_data.dart';
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
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SelectedCableTvPage extends StatefulWidget {
  String image, title, amount;

  SelectedCableTvPage({Key key, this.image, this.title}) : super(key: key);
  @override
  _SelectedCableTvPageState createState() => _SelectedCableTvPageState();
}

class _SelectedCableTvPageState extends State<SelectedCableTvPage> {
  List<ImageList> providerImages;
  List<ImageList> tvType;
  bool checkState;
  List<String> beneficiaries;
  String tvName, tvLogo;
  String userPin, serviceId, meterInitData, packageId;

  String userId, nairaBalance;
  int maxLines = 1;

  TextEditingController _beneficiaryController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _tvSubscriptionplanController =
      new TextEditingController();
  TextEditingController _smartCardController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    userPin = (pref.getString('lock_code') ?? '');
    nairaBalance = (pref.getString('nairaBalance') ?? '');

    setState(() {});
  }

  bool pageState;

  @override
  void initState() {
    super.initState();
    providerImages = DemoData.subImages;
    tvType = DemoData.subImages;
    getData();
    tvName = 'Dstv';
    tvLogo = 'assets/images/dstv.jpg';
    serviceId = 'dstv';
    packageId = '';
    beneficiaries = [
      'Emeka Ofor',
      'Okezie Ikeazu',
      'Nnamdi Kanu',
      'Chinwetalu Okolie'
    ];
    checkState = true;
    pageState = false;

    _smartCardController.text = '121212121212';
    _phoneController.text = '08108803488';
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
                backgroundColor: ColorConstants.primaryColor,
                appBar: TopBar(
                  backgroundColorStart: ColorConstants.primaryColor,
                  backgroundColorEnd: ColorConstants.secondaryColor,
                  icon:
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  title: 'Tv Subscriptions',
                  onPressed: null,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      color: ColorConstants.primaryLighterColor,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
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
                                          _bottomSheetContentTvSubscriptionList(
                                        context,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                            color: ColorConstants
                                                .whiteLighterColor,
                                            width: 0.4)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(tvLogo,
                                                  height: 100, width: 60),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text(tvName,
                                                  style: TextStyle(
                                                      color: ColorConstants
                                                          .whiteColor,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_sharp,
                                            size: 30,
                                            color: ColorConstants
                                                .whiteLighterColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(height: 15),
                              Builder(builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    buildShowBottomSheet(
                                      context: context,
                                      bottomsheetContent:
                                          _bottomSheetContentTvPlan(
                                        context,
                                      ),
                                    );
                                  },
                                  child: IconFields(
                                    hintText: '--Select subscription plan--',
                                    isEditable: false,
                                    maxLines: maxLines,
                                    labelText: widget.title,
                                    controller: _tvSubscriptionplanController,
                                    onChanged: (String i) {
                                      if (i.length >= 1) {
                                        maxLines = 2;
                                      }
                                    },
                                  ),
                                );
                              }),
                              SizedBox(height: 15),
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
                              // SizedBox(height: 15),
                              NormalFields(
                                width: MediaQuery.of(context).size.width,
                                hintText: 'Smart card number',
                                labelText: '',
                                onChanged: (name) {},
                                textInputType: TextInputType.number,
                                controller: _smartCardController,
                              ),
                              SizedBox(height: 15),
                              NormalFields(
                                width: MediaQuery.of(context).size.width,
                                hintText: 'Phone number',
                                labelText: '',
                                onChanged: (name) {},
                                textInputType: TextInputType.number,
                                controller: _phoneController,
                              ),

                              SizedBox(height: 5),
                              Text('Balance: NGN $nairaBalance',
                                  style: TextStyle(
                                      color: ColorConstants.whiteLighterColor,
                                      fontSize: 12)),
                              SizedBox(height: 15),
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
                              //           activeColor: ColorConstants.secondaryColor,
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
                              //SizedBox(height: 10),
                              Divider(color: ColorConstants.whiteLighterColor),
                              SizedBox(height: 10),
                              PasswordTextField(
                                icon: Icons.lock_open,
                                textHint: 'Enter pin',
                                controller: _pinController,
                                textInputType: TextInputType.number,
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
                                    onPressed: () {
                                      verifySmartCardNumber();
                                    },
                                    text: 'Pay subscription now'),
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

  Widget _bottomSheetContentTvSubscriptionList(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select Tv Subscription',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _bottomSheetContentTvSubPlan(
            context,
          ),
        ]),
      ],
    );
  }

  Widget _bottomSheetContentTvSubPlan(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: providerImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                title: providerImages[i].title,
                image: providerImages[i].image,
                onTapped: () {
                  setState(() {
                    tvLogo = providerImages[i].image;
                    tvName = providerImages[i].title;
                    kbackBtn(context);
                  });
                });
          }),
    );
  }

  Widget buildListTile({String title, String image, Function onTapped}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            color: ColorConstants.primaryColor,
            margin: EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    image,
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(title,
                    style: TextStyle(
                        color: ColorConstants.whiteLighterColor, fontSize: 14)),
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

  Widget _bottomSheetContentTvPlan(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Tv subscription plan',
        ),
        Expanded(flex: 4, child: buildTvSubscription())
      ],
    );
  }

  Widget buildElectricityCompanyDetails({String title, Function onTapped}) {
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14)),
          ),
        ),
        Divider(
          color: ColorConstants.lighterSecondaryColor,
          height: 0,
        ),
      ],
    );
  }

  void verifySmartCardNumber() async {
    if (_tvSubscriptionplanController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select subscription plan',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_smartCardController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter smart card number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_phoneController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter phone number',
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
        map['service_id'] = serviceId;
        map['userId'] = userId;
        map['smart_card_number'] = _smartCardController.text;

        var response = await http
            .post(HttpService.rootVerifySmartCard, body: map, headers: {
          'Authorization': 'Bearer ' + HttpService.token,
        }).timeout(const Duration(seconds: 15), onTimeout: () {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
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
            payTvSubBill();
            // ShowSnackBar.showInSnackBar(
            //     iconData: Icons.check_circle,
            //     value: message,
            //     context: context,
            //     scaffoldKey: _scaffoldKey,
            //     timer: 5);
          } else if (!status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          cPageState(state: false);
          ShowSnackBar.showInSnackBar(
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
            value: 'check your internet connection',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    }
  }

  void payTvSubBill() async {
    if (_tvSubscriptionplanController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select subscription plan',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_smartCardController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter smart card number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_phoneController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter phone number',
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
        map['service_id'] = serviceId;
        map['smart_card_number'] = _smartCardController.text;
        map['package_id'] = packageId;

        var response =
            await http.post(HttpService.rootPayTvBill, body: map, headers: {
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

          //
          //
          //BuyAirtimeBundle regUser = BuyAirtimeBundle.fromJson(body);
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

            _tvSubscriptionplanController.text = '';
            _smartCardController.text = '';
            _pinController.text = '';
            _phoneController.text = '';

            String balance = data.data.balance.toString();

            SharedPrefrences.addStringToSP("nairaBalance", balance);
          } else if (!status) {
            cPageState(state: false);

            ShowSnackBar.showInSnackBar(
                value: message,
                context: context,
                scaffoldKey: _scaffoldKey,
                timer: 5);
          }
        } else {
          cPageState(state: false);

          ShowSnackBar.showInSnackBar(
              value: 'network error',
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } on SocketException {
        cPageState(state: false);
        ShowSnackBar.showInSnackBar(
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

  Widget buildTvSubscription() {
    switch (tvName.toLowerCase()) {
      case 'dstv':
        return FutureBuilder(
          future: HttpService.dstvPlanList(
              context, userId, 'https://mabro.ng/dev/_app/tv/packages/dstv'),
          builder: (BuildContext context, AsyncSnapshot<DstvCompany> snapshot) {
            DstvCompany dstvCompany = snapshot.data;
            if (snapshot.hasData) {
              if (dstvCompany.data.dstv.length == 0) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount: dstvCompany.data.dstv.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return buildElectricityCompanyDetails(
                          title: dstvCompany.data.dstv[i].package +
                              " " +
                              "NGN" +
                              dstvCompany.data.dstv[i].price.toString(),
                          onTapped: () {
                            setState(() {
                              _tvSubscriptionplanController.text =
                                  dstvCompany.data.dstv[i].package +
                                      " " +
                                      "NGN" +
                                      dstvCompany.data.dstv[i].price.toString();
                              serviceId = dstvCompany.data.dstv[i].serviceId;
                              packageId = dstvCompany.data.dstv[i].packageId;

                              kbackBtn(context);
                            });
                          });
                    });
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
                valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConstants.secondaryColor),
              ));
            }
          },
        );
        break;
      case 'gotv':
        return FutureBuilder(
          future: HttpService.gotvPlanList(
              context, userId, 'https://mabro.ng/dev/_app/tv/packages/gotv'),
          builder:
              (BuildContext context, AsyncSnapshot<GotvDataCompany> snapshot) {
            GotvDataCompany gotvDataCompany = snapshot.data;
            if (snapshot.hasData) {
              if (gotvDataCompany.data.gotv.length == 0) {
                return Container();
              } else {
                return Container(
                  child: ListView.builder(
                      itemCount: gotvDataCompany.data.gotv.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return buildElectricityCompanyDetails(
                            title: gotvDataCompany.data.gotv[i].package +
                                " " +
                                "NGN" +
                                gotvDataCompany.data.gotv[i].price.toString(),
                            onTapped: () {
                              setState(() {
                                _tvSubscriptionplanController.text =
                                    gotvDataCompany.data.gotv[i].package +
                                        " " +
                                        "NGN" +
                                        gotvDataCompany.data.gotv[i].price
                                            .toString();

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
                valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConstants.secondaryColor),
              ));
            }
          },
        );
        break;
      case 'startimes':
        return FutureBuilder(
          future: HttpService.startimesPlanList(context, userId,
              'https://mabro.ng/dev/_app/tv/packages/startimes'),
          builder: (BuildContext context,
              AsyncSnapshot<StartimesDataCompany> snapshot) {
            StartimesDataCompany startimesDataCompany = snapshot.data;
            if (snapshot.hasData) {
              if (startimesDataCompany.data.startimes.length == 0) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount: startimesDataCompany.data.startimes.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return buildElectricityCompanyDetails(
                          title:
                              startimesDataCompany.data.startimes[i].package +
                                  " " +
                                  "NGN" +
                                  startimesDataCompany.data.startimes[i].price
                                      .toString(),
                          onTapped: () {
                            setState(() {
                              _tvSubscriptionplanController.text =
                                  startimesDataCompany
                                          .data.startimes[i].package +
                                      " " +
                                      "NGN" +
                                      startimesDataCompany
                                          .data.startimes[i].price
                                          .toString();

                              kbackBtn(context);
                            });
                          });
                    });
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
                valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConstants.secondaryColor),
              ));
            }
          },
        );
        break;
      default:
        return Container();
    }
  }
}
