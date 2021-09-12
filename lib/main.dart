import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/email_verification_pages/verify_email_code_page.dart';
import 'package:mabro/ui_views/screens/password_setting/set_password_page.dart';
import 'package:mabro/ui_views/screens/phone_number_verification_pages/enter_phone_digit_page.dart';
import 'package:mabro/ui_views/screens/phone_number_verification_pages/phone_otp_screen.dart';
import 'package:mabro/ui_views/screens/splash_screen_page/splash_screen_page.dart';

import 'ui_views/screens/email_verification_pages/sent_email_page.dart';
import 'ui_views/screens/password_setting/verify_password_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  final  pageState = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstants.primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          platform: TargetPlatform.iOS, primarySwatch: Colors.purple),
      home: SplashScreen(),
    );
  }
}
