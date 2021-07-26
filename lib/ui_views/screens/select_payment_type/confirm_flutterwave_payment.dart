import 'dart:io';

import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmFLutterPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              kbackBtn(context);
                            },
                            child: Icon(
                              Platform.isIOS
                                  ? Icons.arrow_back_ios
                                  : Icons.arrow_back,
                              size: 30,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextStyles.textHeadings(
                    textSize: 20,
                    textColor: Colors.black87,
                    textValue:
                        'How would you like to add money to your mabro wallet?'),
                ),
                
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextStyles.textHeadings(
                    textSize: 14,
                    textColor: Colors.black87,
                    textValue:
                        'Use your own bank account, dont deposit cash'),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextStyles.textHeadings(
                    textSize: 14,
                    textColor: Colors.black87,
                    textValue:
                        'Continue to Flutter Wave and complete your deposit within 1 hour'),
                ),
                SizedBox(height: 20),
                CustomButton(
                    margin: 0,
                    disableButton: true,
                    onPressed: () {},
                    text: 'Continue to flutter Wave'),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
