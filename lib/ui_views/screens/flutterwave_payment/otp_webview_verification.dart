//
//
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewOtpVerification extends StatefulWidget {
//   @override
//   WebViewOtpVerificationState createState() => WebViewOtpVerificationState();
// }
//
// class WebViewOtpVerificationState extends State<WebViewOtpVerification> {
//   @override
//   void initState() {
//     super.initState();
//     // Enable hybrid composition.
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'https://flutter.dev',
//     );
//   }
// }