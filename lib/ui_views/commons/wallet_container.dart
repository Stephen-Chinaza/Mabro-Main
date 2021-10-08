import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mabro/core/models/login_user.dart';
import 'package:mabro/core/services/repositories.dart';

import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:http/http.dart' as http;

class BalanceCard extends StatefulWidget {
  final String image;
  final String title;
  final String amount;
  final String nairaEquiv;
  final bool bg;
  final Function onTapped;
  final double elevation;
  final String dateTime;
  final String onClickOpenPage;

  const BalanceCard({
    Key key,
    this.image,
    this.title,
    this.amount,
    this.bg = true,
    this.nairaEquiv = '',
    this.onTapped,
    this.elevation = 0,
    this.dateTime,
    this.onClickOpenPage,
  }) : super(key: key);

  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard>
    with TickerProviderStateMixin {
  bool showBalanceState = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Animation Controllers
  AnimationController animationController1;
  AnimationController animationController2;
  AnimationController animationController3;
  AnimationController animationController4;
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animation4;
  int rotateTime = 0;

  String _email;
  String _password;

  Future<void> checkFirst() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool sBalanace = (pref.getBool('showBalance') ?? false);
    _email = (pref.getString('email_address') ?? '');
    _password = (pref.getString('password') ?? '');
    showBalanceState = sBalanace;
    setState(() {});
  }

  getCurrentDate() {
    return new DateFormat.yMMMMd().add_jm().format(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    checkFirst();

    animationController1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController4 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation1 =
        Tween<double>(begin: 0, end: 180).animate(animationController1);
    animation2 =
        Tween<double>(begin: 180, end: 360).animate(animationController2);
    animation3 =
        Tween<double>(begin: 360, end: 0).animate(animationController3);
    animation4 =
        Tween<double>(begin: 0, end: 1800).animate(animationController4);
  }

  @override
  void dispose() {
    super.dispose();
    animationController1?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(

            child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.white),
                ),
                GestureDetector(
                  onTap: widget.onTapped,
                  child: Card(
                    elevation: 2,
                    color: ColorConstants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(0.0)),
                          gradient: ColorConstants.primaryGradient),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            widget.onClickOpenPage,
                            style: TextStyle(
                              color: ColorConstants.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
        Divider(color: Colors.grey.withOpacity(0.2), height: 0.5),
        Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (showBalanceState) ? widget.amount : '******',
                      style: TextStyle(
                        fontSize:20,
                        color: ColorConstants.whiteLighterColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      (showBalanceState)
                          ? widget.nairaEquiv
                          : (widget.nairaEquiv == '')
                              ? ''
                              : '******',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: ColorConstants.whiteLighterColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (showBalanceState) {
                            showBalanceState = false;
                            SharedPrefrences.addBoolToSP(
                                'showBalance', showBalanceState);
                          } else {
                            showBalanceState = true;
                            SharedPrefrences.addBoolToSP(
                                'showBalance', showBalanceState);
                          }
                        });

                        setState(() {});
                      },
                      child: (showBalanceState)
                          ? Icon(FontAwesomeIcons.eye,
                              size: 16,
                        color: ColorConstants.whiteLighterColor,
                      )
                          : Icon(FontAwesomeIcons.eyeSlash,
                              size: 16,
                        color: ColorConstants.whiteLighterColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'last refreshed @' +
                          ' ' +
                          getCurrentDate().toString(),
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: ColorConstants.whiteLighterColor,

                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          _reloadPage();
                          _rotateChildContinuously();
                        },
                        child: RotateTrans(
                            Image.asset(
                              'assets/images/refresh.png',
                              height: 30,
                              width: 30,
                            ),
                            buildAnimation())),
                  ],
                ),
              ]),
        ))
      ],
    );
  }

  _rotateChildContinuously() {
    setState(() {
      rotateTime++;
      if (rotateTime == 1) {
        animationController1.forward(from: 0);
      } else if (rotateTime == 2) {
        animationController2.forward(from: pi / 2);
      } else if (rotateTime == 3) {
        animationController3.forward(from: pi);
      } else if (rotateTime == 4) {
        animationController4.forward(from: -pi / 2);
      }
    });
  }

  Animation buildAnimation() {
    if (rotateTime == 1 || rotateTime == 0) {
      return animation1;
    } else if (rotateTime == 2) {
      return animation2;
    } else if (rotateTime == 3) {
      return animation3;
    } else if (rotateTime == 4) {
      rotateTime = 0;
      return animation4;
    }
  }

  void _reloadPage() async {
    try {
      var map = Map<String, dynamic>();
      map['email_address'] = _email;
      map['password'] = _password;

      var response = await http
          .post(HttpService.rootLogin, body: map)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'The connection has timed out, please try again!',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5,
        );

        return null;
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        LoginUser loginUser = LoginUser.fromJson(body);

        bool status = loginUser.status;
        String message = loginUser.message;
        if (status) {
          setState(() {
            String firstName = loginUser.data.firstName;
            String phone = loginUser.data.phoneNumber;
            String id = loginUser.data.id.toString();
            String email = loginUser.data.emailAddress;
            String lockCode = loginUser.data.lockCode;
            String nairaBalance = loginUser.data.nairaBalance;

            getCurrentDate().toString();
            SharedPrefrences.addStringToSP("lock_code", lockCode);

            SharedPrefrences.addStringToSP("nairaBalance", nairaBalance);
            SharedPrefrences.addStringToSP("first_name", firstName);
            SharedPrefrences.addStringToSP("phone_number", phone);
            SharedPrefrences.addStringToSP("id", id);
            SharedPrefrences.addStringToSP("email_address", email);
          });
        } else if (!status) {
          ShowSnackBar.showInSnackBar(
              bgColor: ColorConstants.secondaryColor,
              value: message,
              context: context,
              scaffoldKey: _scaffoldKey,
              timer: 5);
        }
      } else {
        ShowSnackBar.showInSnackBar(
            bgColor: ColorConstants.secondaryColor,
            value: 'network error',
            context: context,
            scaffoldKey: _scaffoldKey,
            timer: 5);
      }
    } on SocketException {
      ShowSnackBar.showInSnackBar(
          bgColor: ColorConstants.secondaryColor,
          value: 'check your internet connection',
          context: context,
          scaffoldKey: _scaffoldKey,
          timer: 5);
    }
  }
}

class RotateTrans extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  RotateTrans(this.child, this.animation);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Container(
          child: Transform.rotate(
            angle: animation.value,
            child: Container(
              child: child,
            ),
          ),
        );
      },
    );
  }
}
