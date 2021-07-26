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
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: TextField(
          maxLength: maxLength,
          maxLines: 1,
          cursorColor: ColorConstants.secondaryColor,
          enabled: isEditable,
          onTap: onTap,
          controller: controller,
          onChanged: onChanged,
          keyboardType: textInputType ?? TextInputType.text,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstants.lighterSecondaryColor.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.secondaryColor),
            ),
            hintText: hintText,
            counterText: "",
            hintStyle: TextStyle(color: Colors.black38, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
