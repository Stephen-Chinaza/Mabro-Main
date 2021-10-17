import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NormalFields extends StatelessWidget {
  final int maxLength;
  final String labelText;
  final double hintSize;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isEditable;
  final FocusNode myFocusNode;

  const NormalFields(
      {@required this.labelText,
        this.hintText,
        this.onChanged,
        this.hintSize = 16,
        this.controller,
        this.onTap,
        this.textInputType,
        this.isEditable = true,
        this.width,
        this.myFocusNode,
        this.maxLength = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border:  Border.all(color: ColorConstants.whiteLighterColor, width: 0.5)
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          maxLength: maxLength,
          focusNode: myFocusNode,
          keyboardType: textInputType ?? TextInputType.text,
          cursorColor: ColorConstants.secondaryColor,
          style: TextStyle(color: ColorConstants.white),
          decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: ColorConstants.primaryColor.withOpacity(0.3),
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
              hintText: hintText,
              hintStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.whiteLighterColor,
                  fontSize: hintSize,
                  fontWeight: FontWeight.w300),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
      ),
    );
  }
}
