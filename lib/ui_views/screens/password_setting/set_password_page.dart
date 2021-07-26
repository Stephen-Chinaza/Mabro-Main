import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/screens/password_setting/verify_password_page.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class SetPinPage extends StatefulWidget {
  @override
  _SetPinPageState createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.white,
          body: PinScreen(),
        ),
      ],
    );
  }
}

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String textPin;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: Dims.sizedBoxHeight(height: 50),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: Dims.sizedBoxHeight(
                          height: Dims.screenHeight(context) * 0.12),
                    ),
                    GestureDetector(onTap: () {}, child: _buildSecurityText()),
                    SizedBox(
                      height: Dims.sizedBoxHeight(
                          height: Dims.screenHeight(context) * 0.10),
                    ),
                    PinEntryTextField(
                      showFieldAsBox: false,
                      isTextObscure: true,
                      fieldWidth: 30.0,
                      fontSize: 30.0,
                      fields: 4,
                      onSubmit: (text) {
                        textPin = text as String;

                        kopenPage(
                            context,
                            VerifyPinPage(
                              textPin: textPin,
                            ));
                      },
                    ),
                  ],
                )),
          ]),
    );
  }

  Widget _buildSecurityText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Create your unique 4-digit pin!',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            'Please remember this pin. It will be used to keep your account secured.',
            style: TextStyle(fontSize: 22, color: ColorConstants.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
