import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/lock_screen_page/main_lock_screen.dart';


import 'package:mabro/ui_views/screens/splash_screen_page/splash_screen_page.dart';
import 'package:mabro/webview.dart';

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
  final pageState = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  // Timer _timer;
  @override
  void initState() {
    super.initState();
   // _initializeTimer();
  }

  // void _initializeTimer() {
  //   if (_timer != null) {
  //     _timer.cancel();
  //   }
  //
  //   _timer = Timer(const Duration(seconds: 3), _logOutUser);
  // }
  //
  //
  //
  // void _handleUserInteraction([_]) {
  //   _initializeTimer();
  // }

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
    return GestureDetector(
      // behavior: HitTestBehavior.translucent,
      // onTap: _handleUserInteraction,
      // onPanDown: _handleUserInteraction,
      child: MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(platform: TargetPlatform.iOS, primarySwatch: Colors.purple),
        home: SplashScreen(),
      ),
    );
  }

  // void _logOutUser() {
  //   _timer?.cancel();
  //   _timer = null;
  //
  //   kopenPage(context, MainScreenLock());
  // }
}
