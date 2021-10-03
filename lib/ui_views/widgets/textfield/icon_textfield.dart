import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconFields extends StatelessWidget {
  final String labelText;
  final int maxLength;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final Function onIconTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Color bgColor;
  final bool isEditable;

  const IconFields(
      {Key key,
      this.labelText,
      this.hintText,
      this.maxLength = 200,
      this.onChanged,
      this.width,
      this.onTap,
      this.textInputType,
      this.controller,
      this.bgColor,
      this.isEditable,
      this.onIconTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border:  Border.all(color: ColorConstants.whiteLighterColor, width: 0.6)
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child:
        TextField(
          cursorColor: ColorConstants.secondaryColor,
          enabled: isEditable,
          onTap: onTap,
          maxLength: maxLength,
          controller: controller,
          onChanged: onChanged,
          keyboardType: textInputType ?? TextInputType.text,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              color: ColorConstants.whiteLighterColor,
              fontSize: 16,
              fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            filled: true,
            counterText: "",
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            fillColor: ColorConstants.primaryColor.withOpacity(0.3),
            hintText: hintText,
            hintStyle: TextStyle(color: ColorConstants.whiteLighterColor, fontSize: 16.0),
            suffixIcon: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorConstants.whiteLighterColor,
              size: 30,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ColorConstants.transparent, width: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.transparent),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),

        ),
      ),
    );
  }
}
