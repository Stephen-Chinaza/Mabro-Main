import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/screens/flutterwave_payment/success_page.dart';
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
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String jsonUrl = 'https://mabro.ng/dev2/_app/naira-wallet/verify-transaction';

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
          //initialUrl: 'https://mabro.ng/dev3/exchange/btc',
          debuggingEnabled: false,
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://mabro.ng/dev2/_app/naira-wallet/add-fund-success')) {
              pushPage(context, SuccessPage());
              return NavigationDecision.prevent;
            } else if (request.url.startsWith(jsonUrl)) {
              pushPage(context, SuccessPage());
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');

            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          //onWebResourceError: ,
        ));
  }
}
