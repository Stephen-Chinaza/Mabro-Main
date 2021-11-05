import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/commons/bubble_indication_painter.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/screens/qr_scan_code_page.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveBtcPage extends StatefulWidget {
  @override
  _ReceiveBtcPageState createState() => _ReceiveBtcPageState();
}

class _ReceiveBtcPageState extends State<ReceiveBtcPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  BuildContext dialogContext;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController btcAddressController = TextEditingController();

  PageController _pageController;
  Color left = ColorConstants.whiteLighterColor;
  Color right = ColorConstants.whiteColor;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String title;
  String walletAddress, userId;
  bool hideScanner;
  final dialogContextCompleter = Completer<BuildContext>();

  @override
  void dispose() {
    _pageController?.dispose();
    controller?.dispose();
    super.dispose();

    getData();
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = (pref.getString('userId') ?? '');
    walletAddress = (pref.getString('bitcoin_address') ??
        '3FZbgi29cpjq2GjdwV8eyHuJJnKLtktZc5');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    hideScanner = false;
    title = 'Receive';
    _pageController = PageController();
    walletAddress = '3FZbgi29cpjq2GjdwV8eyHuJJnKLtktZc5';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (hideScanner) {
          //Navigator.pop(context, false);
          setState(() {
            hideScanner = false;
          });
        } else {
          hideScanner = false;
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstants.primaryColor,
        appBar: TopBar(
          backgroundColorStart: ColorConstants.primaryColor,
          backgroundColorEnd: ColorConstants.secondaryColor,
          title: title + ' BTC',
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          onPressed: null,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: _buildMenuBar(context),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.white;
                            title = 'Receive';
                          });
                          hideScanner = false;
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.white;
                            title = 'Transfer';
                          });
                        }
                      },
                      children: <Widget>[
                        new ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: _buildReceiveBtc(context, walletAddress),
                        ),
                        new ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: _buildTransferBtc(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: ColorConstants.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onReceiveButtonPress,
                child: Text(
                  "Receive",
                  style: TextStyle(
                    color: left,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSTransferButtonPress,
                child: Text(
                  "Transfer",
                  style: TextStyle(
                    color: right,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onReceiveButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSTransferButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }


  void showInfDialog(double height, Widget widgets, {String title = 'Info'}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          dialogContext = context;

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)), //this right here
            child: Stack(
              children: [
                Container(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widgets,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildTransferBtc(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 20),
      child: Card(
        color: ColorConstants.primaryLighterColor,
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Recipient Address',
                        style: TextStyle(
                            color: ColorConstants.whiteColor, fontSize: 14)),
                    SizedBox(height: 5),
                    NormalFields(
                      hintText: 'Input BTC address',
                      labelText: 'Input BTC address',
                      controller: btcAddressController,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (email) {},
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap:(){
                              setState(() {
                                hideScanner = true;
                              });

                            },
                            child: Text(
                              "Scan QR",
                              style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              getClipBoardData().then((value) =>
                              {btcAddressController.text = value});
                            },
                            child: Text(
                              "Paste address",
                              style: TextStyle(
                                color: ColorConstants.whiteLighterColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    NormalFields(
                      hintText: 'BTC amount',
                      labelText: '',
                      controller: TextEditingController(text: ''),
                      onChanged: (name) {},
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      margin: 0,
                      disableButton: true,
                      text: 'Continue',
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: hideScanner,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                height: 400,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: (result != null)
                              ? Text(
                                  'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}', textAlign: TextAlign.center,)
                              : Text('Scan a code'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(()  {
        result = scanData;
        btcAddressController.text = result.code;
        hideScanner = false;
      });
    });
  }

  _buildReceiveBtc(BuildContext context, String walletAd) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BTC balance:',
                  style: TextStyle(
                      color: ColorConstants.whiteColor, fontSize: 13)),
              Text('0.002',
                  style: TextStyle(
                      color: ColorConstants.whiteLighterColor, fontSize: 12)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('To:',
                  style: TextStyle(
                      color: ColorConstants.whiteColor, fontSize: 13)),
              Text('My BTC Wallet',
                  style: TextStyle(
                      color: ColorConstants.whiteLighterColor, fontSize: 12)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Card(
          color: ColorConstants.whiteLighterColor,
          child: QrImage(
            data: walletAd,
            version: QrVersions.auto,
            size: 200,
            gapless: true,
            embeddedImage: AssetImage('assets/images/mbl1.jpg'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(40, 40),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text('Waiting for payment...',
            style: TextStyle(
                color: ColorConstants.whiteLighterColor, fontSize: 14)),
        SizedBox(height: 10),
        Card(
          color: ColorConstants.primaryLighterColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(walletAd,
                style: TextStyle(
                    color: ColorConstants.whiteLighterColor, fontSize: 14)),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: new Tooltip(
                    preferBelow: false,
                    message: "Copy",
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorConstants.primaryLighterColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4))),
                      child: Center(
                        child: Text('Copy',
                            style: TextStyle(
                                color: ColorConstants.white, fontSize: 14)),
                      ),
                    ),
                  ),
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: walletAd));
                    ShowSnackBar.showInSnackBar(
                        value: 'Copied! ' + walletAddress,
                        iconData: Icons.check_circle,
                        context: context,
                        scaffoldKey: _scaffoldKey,
                        timer: 5,
                        bgColor: Colors.green);
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      _onShareData(context, walletAddress, 'Share Address'),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryLighterColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4))),
                    child: Center(
                      child: Text('Share',
                          style: TextStyle(
                              color: ColorConstants.white, fontSize: 14)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  _onShareData(BuildContext context, String text, String subject) async {
    final RenderBox box = context.findRenderObject();
    {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Future<String> getClipBoardData() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    return data.text;
  }
}
