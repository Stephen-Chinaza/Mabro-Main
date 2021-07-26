import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/core/models/Settings.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/account_page.dart';

import 'package:mabro/ui_views/screens/phone_number_verification_pages/enter_phone_digit_page.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstname, surname, user, email, phone, accountname, accountnumber;
  bool pageState;
  bool accountState, phoneState;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController surNameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    firstname = '';
    surname = '';
    email = '';
    phone = '';
    accountname = '';
    accountnumber = '';
    getData();

    accountState = false;
    phoneState = false;
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = (pref.getString('email_address') ?? '');
    firstname = (pref.getString('first_name') ?? '');
    surname = (pref.getString('surname') ?? '');
    phone = (pref.getString('phone_number') ?? '');
    accountnumber = (pref.getString('account_number') ?? '');
    accountname = (pref.getString('account_name') ?? '');
    user = (pref.getString('user') ?? '');

    if (accountnumber == '') {
      accountState = false;
      firstname = 'bank account verification pending';
      surname = 'bank account verification pending';
      accountnumber = 'bank account verification pending';
      accountname = 'bank account verification pending';
    } else {
      accountState = true;
    }

    if (phone == '') {
      phoneState = false;
      phone = 'phone number verification pending';
    } else {
      phoneState = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                title: "",
                actions: <Widget>[],
              ),
              const SizedBox(height: 10.0),
              _buildUserInfo(),
            ],
          ),
        ));
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(4),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          buildListTile(
                              title: 'First Name',
                              subTitle: surname,
                              icon: Icons.person,
                              hideEdit: accountState,
                              onTap: () {
                                openAccountPage();
                              }),
                          buildListTile(
                              title: 'Last Name',
                              subTitle: firstname,
                              icon: Icons.person,
                              hideEdit: accountState,
                              onTap: () {
                                openAccountPage();
                              }),
                          buildListTile(
                              title: 'Email',
                              subTitle: email,
                              icon: Icons.email,
                              hideEdit: true),
                          buildListTile(
                              title: 'Phone',
                              subTitle: phone,
                              icon: Icons.phone,
                              hideEdit: phoneState,
                              onTap: () {
                                openEditPhone();
                              }),
                          buildListTile(
                              title: 'Account Name',
                              subTitle: accountname,
                              icon: Icons.comment_bank,
                              hideEdit: accountState,
                              onTap: () {
                                openAccountPage();
                              }),
                          buildListTile(
                              title: 'Account Number',
                              subTitle: accountnumber,
                              icon: Icons.cloud_done,
                              hideEdit: accountState,
                              onTap: () {
                                openAccountPage();
                              }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  openEditPhone() {
    kopenPage(context, ConfirmPhoneNScreen());
  }

  openAccountPage() {
    kopenPage(context, AccountPage());
  }

  ListTile buildListTile(
      {String title,
      String subTitle,
      IconData icon,
      bool hideEdit = true,
      Function onTap}) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: Container(
          height: 50,
          width: 50,
          child: Card(
            elevation: 3,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: ColorConstants.primaryGradient,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 22,
                  color: ColorConstants.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subTitle.toLowerCase(),
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        trailing: (hideEdit)
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  onTap();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: Card(
                    elevation: 3,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: ColorConstants.primaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.edit,
                          size: 22,
                          color: ColorConstants.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      this.coverImage,
      this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 150,
          decoration: BoxDecoration(
            gradient: ColorConstants.primaryGradient,
          ),
        ),
        Ink(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 110),
          child: Column(
            children: <Widget>[
              Avatar(
                image: AssetImage(
                  'assets/images/mbl1.png',
                ),
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor = ColorConstants.primaryColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : ColorConstants.primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
