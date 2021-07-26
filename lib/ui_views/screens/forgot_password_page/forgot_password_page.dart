import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/screens/forgot_password_page/reset_password.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FocusNode myFocusNodeEmail = FocusNode();

  TextEditingController signinEmailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myFocusNodeEmail.dispose();
    signinEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextStyles.textHeadings(
                textValue: 'Reset Password',
                textSize: 30,
                textColor: Colors.red),
            SizedBox(
              height: Dims.sizedBoxHeight(height: 20),
            ),
            Divider(color: Colors.grey.withOpacity(0.2), height: 0.5),
            SizedBox(
              height: Dims.sizedBoxHeight(height: 30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextStyles.textDetails(
                  textValue:
                      'Please provide the following details to reset your password.',
                  textSize: 14,
                  textColor: Colors.black),
            ),
            SizedBox(
              height: Dims.sizedBoxHeight(height: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedTextfield(
                icon: Icons.email_outlined,
                hintText: 'Please Enter Email',
                labelText: 'Email',
                controller: signinEmailController,
                myFocusNode: myFocusNodeEmail,
                textInputType: TextInputType.emailAddress,
                onChanged: (email) {},
              ),
            ),
            SizedBox(
              height: Dims.sizedBoxHeight(height: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  margin: 0,
                  disableButton: true,
                  onPressed: () {
                    kopenPage(
                        context,
                        ResetPasswordPage(
                          userEmail: signinEmailController.text,
                        ));
                  },
                  text: 'Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
