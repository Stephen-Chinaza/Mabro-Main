import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedTextfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final double textfieldElevation;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isEditable;
  final FocusNode myFocusNode;
  final IconData icon;
  final Color iconColor;

  const RoundedTextfield(
      {@required this.labelText,
      this.hintText,
      this.onChanged,
      this.controller,
      this.onTap,
      this.textInputType,
      this.isEditable = true,
      this.width,
      this.myFocusNode,
      this.textfieldElevation = 0,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        focusNode: myFocusNode,
        keyboardType: textInputType ?? TextInputType.text,
        cursorColor: ColorConstants.primaryColor,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstants.lighterSecondaryColor.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.secondaryColor),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.black38,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            prefixIcon: (icon == null)
                ? Container()
                : Icon(
                    icon,
                    color: (iconColor == null)
                        ? ColorConstants.primaryColor
                        : iconColor,
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
      ),
    );
  }
}
