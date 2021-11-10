import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  final ImageProvider logo;
  final Image image;
  final String phoneNumber;
  final String phoneNumberText;
  final String website;
  final String websiteText;
  final String email;
  final String emailText;
  final String twitterHandle;
  final String facebookHandle;
  final String linkedinURL;
  final String githubUserName;
  final String companyName;
  final double companyFontSize;
  final String tagLine;
  final String instagram;
  final Color textColor;
  final Color cardColor;
  final Color companyColor;
  final Color taglineColor;

  ContactUs(
      {@required this.companyName,
      @required this.textColor,
      @required this.cardColor,
      @required this.companyColor,
      @required this.taglineColor,
      @required this.email,
      this.emailText,
      this.logo,
      this.image,
      this.phoneNumber,
      this.phoneNumberText,
      this.website,
      this.websiteText,
      this.twitterHandle,
      this.facebookHandle,
      this.linkedinURL,
      this.githubUserName,
      this.tagLine,
      this.instagram,
      this.companyFontSize});

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.primaryColor,
          elevation: 8.0,
          contentPadding: EdgeInsets.all(18.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
            color: ColorConstants.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => launch('tel:' + phoneNumber),
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Text('Call',
                        style:
                            TextStyle(color: ColorConstants.whiteLighterColor)),
                  ),
                ),
                Divider(
                  color: ColorConstants.whiteLighterColor,
                ),
                InkWell(
                  onTap: () => launch('https://wa.me/' + phoneNumber),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text('WhatsApp',
                        style:
                            TextStyle(color: ColorConstants.whiteLighterColor)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'IcezTech',
        textColor: ColorConstants.whiteLighterColor,
        backgroundColor: Colors.transparent,
        email: 'iceztech@gmail.com',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Card(
            color: ColorConstants.primaryLighterColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        kbackBtn(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Platform.isIOS
                              ? Icons.arrow_back_ios
                              : Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: tagLine != null,
                      child: Text(
                        tagLine ?? "",
                        style: TextStyle(
                          color: taglineColor,
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container()
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: ColorConstants.whiteLighterColor,
                  thickness: 4,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Visibility(
                  visible: phoneNumber != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Card(
                        elevation: 5,
                        color: ColorConstants.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Typicons.phone,
                              size: 20,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        phoneNumberText ?? 'Phone number',
                        style: TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () => showAlert(context),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 6.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: cardColor,
                  child: ListTile(
                    leading: Card(
                      elevation: 5,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: ColorConstants.primaryGradient1,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Typicons.mail,
                            size: 20,
                            color: ColorConstants.white,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      emailText ?? 'Email Us',
                      style: TextStyle(
                        color: ColorConstants.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () => launch('mailto:' + email),
                  ),
                ),
                Visibility(
                  visible: twitterHandle != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Typicons.social_twitter,
                              size: 20,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Twitter',
                        style: TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () =>
                          launch('https://twitter.com/' + twitterHandle),
                    ),
                  ),
                ),
                Visibility(
                  visible: facebookHandle != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Typicons.social_facebook,
                              size: 20,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Facebook',
                        style: TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () =>
                          launch('https://www.facebook.com/' + facebookHandle),
                    ),
                  ),
                ),
                Visibility(
                  visible: instagram != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Typicons.social_instagram,
                              size: 20,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Instagram',
                        style: TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () => launch('https://instagram.com/' + instagram),
                    ),
                  ),
                ),
                Visibility(
                  visible: githubUserName != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Typicons.social_github,
                              size: 20,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Github',
                        style: TextStyle(
                          color: ColorConstants.secondaryColor,
                        ),
                      ),
                      onTap: () =>
                          launch('https://github.com/' + githubUserName),
                    ),
                  ),
                ),
                Visibility(
                  visible: linkedinURL != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: ColorConstants.primaryGradient1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Typicons.social_linkedin,
                              size: 20,
                              color: ColorConstants.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Linkedin',
                        style: TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () => launch(linkedinURL),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class ContactUsBottomAppBar extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String email;
  final String companyName;
  final double fontSize;

  ContactUsBottomAppBar(
      {@required this.textColor,
      @required this.backgroundColor,
      @required this.email,
      @required this.companyName,
      this.fontSize = 12.0});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: backgroundColor,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(
        'Designed and Developed by $companyName \nWant to contact?',
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      onPressed: () => launch('mailto:$email'),
    );
  }
}
