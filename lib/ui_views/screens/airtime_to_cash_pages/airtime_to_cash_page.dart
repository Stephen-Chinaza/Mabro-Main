import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/demo_data.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/bottomsheet_header.dart';
import 'package:mabro/ui_views/commons/show_phone_contact/contacts_page.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/textfield_with_image.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'comfirm_airtime_to_cash_page.dart';

class AirtimeToCashPage extends StatefulWidget {
  final String phone;

  const AirtimeToCashPage({Key key, this.phone = ''}) : super(key: key);
  @override
  _AirtimeToCashPageState createState() => _AirtimeToCashPageState();
}

class _AirtimeToCashPageState extends State<AirtimeToCashPage> {
  String _name;
  int _selectedIndex;
  List<ImageList> providerImages;
  bool showTransactionInfo;
  String network;

  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showTransactionInfo = false;
    network = 'mtn';

    if (widget.phone == '') {
      _name = '';
    } else {
      _name = widget.phone;
    }

    _selectedIndex = 0;
    providerImages = DemoData.images;
  }

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.white,
          appBar: TopBar(
            backgroundColorStart: ColorConstants.primaryColor,
            backgroundColorEnd: ColorConstants.secondaryColor,
            title: 'Airtime To Cash',
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onPressed: null,
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    TextStyles.textDetails(
                      textSize: 14,
                      textColor: Colors.black,
                      textValue: 'Select mobile carrier',
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: providerImages.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(8.0),
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
                                          color: _selectedIndex != null &&
                                                  _selectedIndex == i
                                              ? Colors.redAccent
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      height: 80,
                                      width: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                            providerImages[i].image),
                                      ))),
                            );
                          }),
                    ),
                    SizedBox(height: 20),
                    TextStyles.textDetails(
                      textSize: 14,
                      textColor: Colors.black,
                      textValue: 'You are transfering from?',
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
                            controller: phoneController,
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
                    SizedBox(height: 25),
                    NormalFields(
                      hintText: 'Enter amount',
                      labelText: '',
                      textInputType: TextInputType.number,
                      controller: amountController,
                      onChanged: (String text) {
                        setState(() {
                          if (int.parse(amountController.text) >= 2000 &&
                              phoneController.text != '') {
                            showTransactionInfo = true;
                          } else {
                            showTransactionInfo = false;
                          }
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyles.textDetails(
                            textSize: 12,
                            textColor: Colors.red,
                            textValue: 'Side Note:',
                          ),
                          SizedBox(height: 10),
                          TextStyles.textDetails(
                              textSize: 12,
                              textColor: Colors.red,
                              textValue: '*Once airtime is sucessfully sent, ' +
                                  'your wallet will be credited within 5 minutes, then you ' +
                                  'can withdraw to your bank account,'),
                          SizedBox(height: 10),
                          TextStyles.textDetails(
                            textColor: Colors.red,
                            textSize: 12,
                            textValue:
                                '*do not transfer airtime less than NGN2000 ',
                          ),
                          SizedBox(height: 10),
                          TextStyles.textDetails(
                            textColor: Colors.red,
                            textSize: 12,
                            textValue: '*If you have multiple airtime to sell,' +
                                'you are allowed to convert only 20,000 per day ',
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 20),
                    Visibility(
                      visible: showTransactionInfo,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.textDetails(
                                textSize: 12,
                                textValue: 'Transaction Information',
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextStyles.textDetails(
                                              textSize: 12,
                                              textValue: 'Charges: ',
                                            ),
                                            TextStyles.textDetails(
                                              textSize: 12,
                                              textValue: '500NGN',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextStyles.textDetails(
                                              textSize: 12,
                                              textColor: Colors.black,
                                              textValue: 'You will Receive: ',
                                            ),
                                            TextStyles.textDetails(
                                              textSize: 12,
                                              textColor: Colors.black,
                                              textValue: '1500NGN',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                        disableButton: true,
                        onPressed: () {
                          kopenPage(context, ConfirmTransferPage());
                        },
                        text: 'Continue'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildShowBottomSheet(BuildContext context) {
    return showBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey[300],
                          spreadRadius: 1)
                    ]),
                height: Dims.screenHeight(context),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    buildFirstContainer(),
                    buildSecondContainer(),
                    Column(
                      children: [
                        BottomSheetHeader(
                          buttomSheetTitle: 'Account Setup',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                TextStyles.textDetails(
                                  textSize: 12,
                                  textColor: Colors.black38,
                                  textValue:
                                      'Add bank account information and Bvn',
                                ),
                                SizedBox(height: 20),
                                NormalFields(
                                  width: MediaQuery.of(context).size.width,
                                  hintText: 'Select Bank',
                                  labelText: 'Bank Names',
                                  onChanged: (name) {
                                    print(name);
                                    _name = name;
                                  },
                                  controller:
                                      TextEditingController(text: _name),
                                ),
                                SizedBox(height: 15),
                                NormalFields(
                                  width: MediaQuery.of(context).size.width,
                                  hintText: 'Enter Account Number',
                                  labelText: 'Account Number',
                                  onChanged: (name) {
                                    _name = name;
                                  },
                                  controller:
                                      TextEditingController(text: _name),
                                ),
                                SizedBox(height: 15),
                                NormalFields(
                                  width: MediaQuery.of(context).size.width,
                                  isEditable: false,
                                  hintText: 'Enter Account Name',
                                  labelText: 'Account Name',
                                  onChanged: (name) {
                                    _name = name;
                                  },
                                  controller:
                                      TextEditingController(text: _name),
                                ),
                                SizedBox(height: 15),
                                NormalFields(
                                  width: MediaQuery.of(context).size.width,
                                  hintText: 'Enter Bank Verification Number',
                                  labelText: 'Enter BVN',
                                  onChanged: (name) {
                                    print(name);
                                    _name = name;
                                  },
                                  controller:
                                      TextEditingController(text: _name),
                                ),
                                SizedBox(height: 20),
                                TextStyles.textDetails(
                                  textSize: 12,
                                  textColor: Colors.black38,
                                  textValue:
                                      'We are a digital bank and just like your regular bank,we need your BVN to be able to process transactios. Dial *565*0# on your mobile phone to get your bvn.',
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                    disableButton: true,
                                    onPressed: () => kopenPage(
                                        context, ConfirmTransferPage()),
                                    text: 'Submit'),
                              ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  void getContacts() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactsPage()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Permissions error'),
                content: Text('Please enable contacts access '
                    'permission in system settings'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }
}
