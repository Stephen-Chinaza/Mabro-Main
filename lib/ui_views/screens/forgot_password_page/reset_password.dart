import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/password_textfield.dart';
import 'package:mabro/ui_views/widgets/textfield/rounded_textfield.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  final String userEmail;

  const ResetPasswordPage({Key key, this.userEmail}) : super(key: key);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeCPassword = FocusNode();
  final FocusNode myFocusNodeToken = FocusNode();

  TextEditingController signinEmailController = new TextEditingController();
  TextEditingController signinPasswordController = new TextEditingController();
  TextEditingController signinCPasswordController = new TextEditingController();
  TextEditingController tokenController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    signinEmailController.text = widget.userEmail;
  }

  @override
  void dispose() {
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    myFocusNodeCPassword.dispose();
    myFocusNodeToken.dispose();
    signinEmailController.dispose();
    signinPasswordController.dispose();
    signinCPasswordController.dispose();
    tokenController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
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
                        'A token has been sent to your email please provide the following details to reset your password.',
                    textSize: 14,
                    textColor: ColorConstants.secondaryColor),
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(height: 30),
              ),
              RoundedTextfield(
                icon: Icons.email_outlined,
                hintText: 'Please Enter Email',
                labelText: 'Email',
                controller: signinEmailController,
                myFocusNode: myFocusNodeEmail,
                textInputType: TextInputType.emailAddress,
                onChanged: (email) {},
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(),
              ),
              PasswordTextField(
                icon: Icons.lock_open,
                textHint: 'Password',
                controller: signinPasswordController,
                myFocusNode: myFocusNodePassword,
                labelText: '',
                onChanged: (password) {},
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(),
              ),
              PasswordTextField(
                icon: Icons.lock_open,
                textHint: 'Password',
                controller: signinPasswordController,
                myFocusNode: myFocusNodePassword,
                labelText: '',
                onChanged: (password) {},
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(),
              ),
              RoundedTextfield(
                icon: Icons.email_outlined,
                hintText: 'Enter Token',
                labelText: 'Token',
                controller: signinEmailController,
                myFocusNode: myFocusNodeEmail,
                textInputType: TextInputType.emailAddress,
                onChanged: (email) {},
              ),
              SizedBox(
                height: Dims.sizedBoxHeight(height: 30),
              ),
              CustomButton(
                  margin: 0,
                  disableButton: true,
                  onPressed: () {},
                  text: 'Reset Password'),
            ],
          ),
        ),
      ),
    );
  }
}
