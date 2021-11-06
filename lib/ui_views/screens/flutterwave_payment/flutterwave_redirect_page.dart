import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

class FlutterWaveRedirectPage extends StatefulWidget {
  final String linkUrl;

  const FlutterWaveRedirectPage({Key key, this.linkUrl}) : super(key: key);
  @override
  FlutterWaveRedirectPageState createState() => FlutterWaveRedirectPageState();
}

class FlutterWaveRedirectPageState extends State<FlutterWaveRedirectPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        appBar: TopBar(
          backgroundColorStart: ColorConstants.primaryColor,
          backgroundColorEnd: ColorConstants.secondaryColor,
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          title: 'OTP Verification',
          onPressed: null,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        body: WebView(
          initialUrl: widget.linkUrl,
          debuggingEnabled: false,
          gestureNavigationEnabled: true,
          //onWebResourceError: ,
        ));
  }
}
