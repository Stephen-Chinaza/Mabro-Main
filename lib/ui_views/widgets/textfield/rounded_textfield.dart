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
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border:
              Border.all(color: ColorConstants.whiteLighterColor, width: 0.2)),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        focusNode: myFocusNode,
        keyboardType: textInputType ?? TextInputType.text,
        cursorColor: ColorConstants.secondaryColor,
        style: TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: ColorConstants.primaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                  color: ColorConstants.whiteColor, width: 0.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstants.whiteColor, width: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.transparent),
              borderRadius: BorderRadius.circular(4.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                fontStyle: FontStyle.normal,
                color: ColorConstants.whiteLighterColor,
                fontSize: 16,
                fontWeight: FontWeight.w300),
            prefixIcon: (icon == null)
                ? SizedBox.shrink()
                : Icon(
                    icon,
                    color: (iconColor == null)
                        ? ColorConstants.whiteLighterColor
                        : iconColor,
                    size: 22,
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
      ),
    );
  }
}
