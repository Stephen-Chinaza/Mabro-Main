import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/helpers/sharedprefrences.dart';
import 'package:mabro/ui_views/screens/authentication_pages/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class GetStartedButton extends StatefulWidget {
  @override
  _GetStartedButtonState createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      width: 150.0,
      child: CustomButton(
          disableButton: true,
          borderRadius: 30,
          onPressed: () {
            SharedPrefrences.addBoolToSP('isonBoardTrue', true);
            pushPage(
              context,
              SignUpPage(),
            );
          },
          text: 'Get Started'),
    );
  }
}
