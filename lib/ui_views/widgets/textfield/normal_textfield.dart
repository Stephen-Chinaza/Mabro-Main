import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NormalFields extends StatelessWidget {
  final int maxLength;
  final String labelText;
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
          focusNode: myFocusNode,
          keyboardType: textInputType ?? TextInputType.text,
          cursorColor: ColorConstants.secondaryColor,
          style: TextStyle(color: ColorConstants.white),
          decoration: InputDecoration(
              filled: true,
              fillColor: ColorConstants.primaryColor.withOpacity(0.6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.whiteLighterColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
      ),
    );
  }
}
