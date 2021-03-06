import 'dart:io';

import 'package:flutter_contacts/contact.dart';
import 'package:intl/intl.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/buy_airtime_bundle.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/core/models/electricity_data_companies.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class SelectedElectricitySubPage extends StatefulWidget {
  String image, title, amount;
  final Contact contact;

  SelectedElectricitySubPage(
      {Key key, this.image, this.title, this.contact = null})
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
  List<String> meterType;
  String electName, electLogo;
  String userPin, serviceId, meterInitData;

  String userId, nairaBalance;

  TextEditingController _beneficiaryController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _meterTypeController = new TextEditingController();
  TextEditingController _meterNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  int _selectedIndex;
  bool pageState;

  @override
  void initState() {
    super.initState();
    getBalance();
    providerImages = DemoData.electricityImages;
    rechargeAmount = DemoData.airtime;

    electName = 'Abuja Electricity Distribution Company- AEDC';
    electLogo = 'assets/images/ekoelect.jpg';
    pageState = false;

    _meterNumberController.text = '1111111111111';
    //_phoneController.text = '08011111111';
    _amountController.text = '2000';
    meterInitData = 'Prepaid';
    _meterTypeController.text = meterInitData;
    serviceId = 'abuja-electric';

    meterType = [
      'Prepaid',
      'Postpaid',
    ];
    checkState = true;
    _selectedIndex = 0;

    if (widget.contact == null) {
      _phoneController.text = '08011111111';
    } else {
      _phoneController.text = widget.contact.phones.isNotEmpty
          ? widget.contact.phones.first.number
          : '(none)';
    }
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
                  title: 'Electricity bills',
                  onPressed: null,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Card(
                    elevation: 3,
                    color: ColorConstants.primaryLighterColor,
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
                                        _bottomSheetContentElectricityCompanies(
                                      context,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                          color:
                                              ColorConstants.whiteLighterColor,
                                          width: 0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Image.asset(electLogo,
                                                  height: 60, width: 60),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(electName,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: ColorConstants
                                                          .whiteColor,
                                                      fontSize: 12)),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_sharp,
                                          size: 30,
                                          color:
                                              ColorConstants.whiteLighterColor,
                                        ),
                                      ],
                                    ),
                                  ),
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
                            Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  buildShowBottomSheet(
                                    context: context,
                                    bottomsheetContent:
                                        _bottomSheetContentMeterType(
                                      context,
                                    ),
                                  );
                                },
                                child: IconFields(
                                  hintText: 'Select meter type',
                                  isEditable: false,
                                  labelText: widget.title,
                                  controller: _meterTypeController,
                                ),
                              );
                            }),
                            SizedBox(height: 15),
                            NormalFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: 'Meter number',
                              labelText: '',
                              textInputType: TextInputType.number,
                              onChanged: (name) {},
                              controller: _meterNumberController,
                            ),
                            SizedBox(height: 15),
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
                                            pageTitle: 'electricity',
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
                            SizedBox(height: 15),
                            NormalFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: 'Enter Amount',
                              labelText: '',
                              textInputType: TextInputType.number,
                              onChanged: (name) {},
                              controller: _amountController,
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
                            // SizedBox(height: 10),
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
                                    verifyMeterNumber();
                                  },
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

  Widget _bottomSheetContentMeterType(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select meter type',
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 6),
          _buildMeterTypeList(
            context,
          ),
        ]),
      ],
    );
  }

  Widget _buildMeterTypeList(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: meterType.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return buildListTile(
                title: meterType[i],
                onTapped: () {
                  setState(() {
                    _meterTypeController.text = meterType[i];
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
            width: MediaQuery.of(context).size.width,
            color: ColorConstants.primaryColor,
            margin: EdgeInsets.all(8),
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.whiteLighterColor,
                    fontSize: 14)),
          ),
        ),
        Divider(color: ColorConstants.whiteLighterColor),
      ],
    );
  }

  Widget _bottomSheetContentElectricityCompanies(
    BuildContext context,
  ) {
    return Column(
      children: [
        BottomSheetHeader(
          buttomSheetTitle: 'Select electricity company',
        ),
        Expanded(
          child: buildElectricity(
            context,
            HttpService.rootElectricityCompanyList,
          ),
        ),
      ],
    );
  }

  Widget buildElectricityCompanyDetails(
      {String title, String image, Function onTapped}) {
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
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.whiteLighterColor,
                        fontSize: 14)),
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

  FutureBuilder<ElectricityCompanyList> buildElectricity(
      BuildContext context, String url) {
    return FutureBuilder(
      future: HttpService.electricityCompanyList(context, userId, url),
      builder: (BuildContext context,
          AsyncSnapshot<ElectricityCompanyList> snapshot) {
        ElectricityCompanyList electricityCompanyList = snapshot.data;

        if (snapshot.hasData) {
          if (electricityCompanyList.data.electricity.length == 0) {
            return Center(
              child: Text(
                'Network error',
                style: TextStyle(
                    fontSize: 16, color: ColorConstants.secondaryColor),
              ),
            );
          } else {
            return Container(
              child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return buildElectricityCompanyDetails(
                        title: electricityCompanyList.data.electricity[i].name,
                        image: providerImages[i].image,
                        onTapped: () {
                          setState(() {
                            electName =
                                electricityCompanyList.data.electricity[i].name;
                            electLogo = providerImages[i].image;
                            serviceId = electricityCompanyList
                                .data.electricity[i].serviceId;
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
                    'Error in network',
                    style: TextStyle(
                        fontSize: 16, color: ColorConstants.whiteLighterColor),
                  ),
                  Icon(
                    Icons.refresh,
                    size: 25,
                  )
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

  void verifyMeterNumber() async {
    if (_meterTypeController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select data bundle',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_meterNumberController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter meter number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_phoneController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter phone number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter amount',
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
        map['meter_number'] = _meterNumberController.text;
        map['meter_type'] = _meterTypeController.text;

        var response = await http
            .post(HttpService.rootVerifyMeterNumber, body: map, headers: {
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

          BuyAirtimeBundle regUser = BuyAirtimeBundle.fromJson(body);

          bool status = regUser.status;
          String message = regUser.message;
          if (status) {
            cPageState(state: false);
            payElectricityBill();
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

  void payElectricityBill() async {
    if (_meterTypeController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Select meter type',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_meterNumberController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter meter number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_phoneController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter phone number',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    } else if (_amountController.text.isEmpty) {
      ShowSnackBar.showInSnackBar(
          value: 'Enter amount',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
    //else if (_pinController.text.isEmpty) {
    // ShowSnackBar.showInSnackBar(
    //     value: 'Enter transaction pin',
    //     context: context,
    //     scaffoldKey: _scaffoldKey);
    // } else if (userPin != _pinController.text) {
    //   ShowSnackBar.showInSnackBar(
    //       value: 'Invalid pin entered',
    //       context: context,
    //       scaffoldKey: _scaffoldKey);
    //}
    else {
      cPageState(state: true);
      try {
        var map = Map<String, dynamic>();
        map['userId'] = userId;
        map['service_id'] = serviceId;
        map['meter_number'] = _meterNumberController.text;
        map['meter_type'] = _meterTypeController.text;
        map['phone_number'] = _phoneController.text;
        map['amount'] = _amountController.text;
        print(userId);
        print(serviceId);
        var response = await http
            .post(HttpService.rootPayElectricityBill, body: map, headers: {
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
}
