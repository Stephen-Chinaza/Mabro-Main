import 'package:flutter/cupertino.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/screens/menu_option_pages/account_page.dart';
import 'package:mabro/ui_views/screens/phone_number_verification_pages/enter_phone_digit_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstname, surname, userId, email, phone, accountname, accountnumber;
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
    userId = (pref.getString('userId') ?? '');

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
        backgroundColor: ColorConstants.primaryColor,
        body: SingleChildScrollView(
          child: _buildUserInfo(),
        ));
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Card(
            color: ColorConstants.primaryLighterColor,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileHeader(
                    title: "MY PROFILE",
                    subtitle: email,
                    actions: <Widget>[],
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: ColorConstants.whiteLighterColor,
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      buildListTile(
                          title: 'First name',
                          subTitle: surname,
                          icon: Icons.person,
                          hideEdit: accountState,
                          onTap: () {
                            openAccountPage();
                          }),
                      buildListTile(
                          title: 'Last name',
                          subTitle: firstname,
                          icon: Icons.person,
                          hideEdit: accountState,
                          onTap: () {
                            openAccountPage();
                          }),

                      buildListTile(
                          title: 'Phone',
                          subTitle: phone,
                          icon: Icons.phone,
                          hideEdit: false,
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

  Widget buildListTile(
      {String title,
      String subTitle,
      IconData icon,
      bool hideEdit = true,
      Function onTap}) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        leading: Container(
          height: 50,
          width: 50,
          child: Card(
            elevation: 3,
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
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: ColorConstants.whiteLighterColor,
          ),
        ),
        subtitle: Text(
          subTitle.toLowerCase(),
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: ColorConstants.whiteLighterColor,
            fontSize: 14,
          ),
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
                  child: Container(
                    decoration: BoxDecoration(
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
    return SafeArea(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Avatar(
              image: AssetImage(
                'assets/images/mbl1.png',
              ),
              radius: 30,
              backgroundColor: Colors.white,
              borderColor: Colors.grey.shade300,
              borderWidth: 2.0,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: ColorConstants.whiteLighterColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'email: $subtitle',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: ColorConstants.secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
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
      this.borderColor = ColorConstants.primaryColor,
      this.backgroundColor = ColorConstants.primaryColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: ColorConstants.secondaryColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? ColorConstants.primaryColor
            : ColorConstants.primaryColor,
        child: Container(
            child: Icon(Icons.person, color: ColorConstants.white, size: 40)),
      ),
    );
  }
}
