import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static textHeadings(
      {@required String textValue, double textSize = 18, Color textColor}) {
    return Text(
      textValue ?? '',
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: textColor,
          fontSize: textSize,
          fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }

  static textSubHeadings({
    @required String textValue,
    double textSize = 14,
    Color textColor,
    bool centerText = false,
  }) {
    return Text(
      textValue ?? '',
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: textColor,
          fontSize: textSize,
          fontWeight: FontWeight.bold),
      textAlign: (centerText) ? TextAlign.center : TextAlign.start,
    );
  }

  static textDetails({
    @required String textValue,
    double textSize = 12,
    double lineSpacing = 1.1,
    Color textColor,
    bool centerText = false,
  }) {
    return Text(
      textValue ?? '',
      textAlign: (centerText) ? TextAlign.center : TextAlign.start,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: textColor,
          fontSize: textSize,
          fontWeight: FontWeight.w600),
    );
  }

  static richTexts(
      {String text1,
      String text2,
      double size = 16,
      String text3 = '',
      String text4 = '',
      Function onPress1,
      bool centerText = false,
      Function onPress2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: (centerText) ? TextAlign.justify : TextAlign.justify,
          text: TextSpan(children: [
            TextSpan(
              text: text1,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: size,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onPress1();
                },
              text: text2,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.primaryColor,
                  fontSize: size,
                  fontWeight: FontWeight.w400),
            ),
          ]),
        ),
        RichText(
          textAlign: (centerText) ? TextAlign.center : TextAlign.start,
          text: TextSpan(children: <InlineSpan>[
            TextSpan(
              text: text3,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: size,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    onPress2();
                  },
                text: text4,
                style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: size,
                    fontWeight: FontWeight.w400)),
          ]),
        ),
      ],
    );
  }
}
