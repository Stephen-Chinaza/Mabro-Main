import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWithEndText extends StatelessWidget {
  final String labelText;
  final String inputCurrencyType;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final Function onIconTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Color bgColor;
  final bool isEditable;

  const TextFieldWithEndText(
      {Key key,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.width,
      this.onTap,
      this.textInputType,
      this.controller,
      this.bgColor,
      this.isEditable,
      this.onIconTap,
      this.inputCurrencyType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border:
              Border.all(color: ColorConstants.whiteLighterColor, width: 0.5)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 2.0, right: 2.0, top: 0, bottom: 0),
        child: Material(
          color: ColorConstants.primaryColor,
          elevation: 3,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      cursorColor: ColorConstants.secondaryColor,
                      enabled: isEditable,
                      onTap: onTap,
                      controller: controller,
                      onChanged: onChanged,
                      keyboardType: textInputType ?? TextInputType.text,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: ColorConstants.whiteLighterColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorConstants.primaryColor.withOpacity(0.3),
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: ColorConstants.whiteLighterColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(inputCurrencyType ?? '',
                    style: TextStyle(
                      color: ColorConstants.whiteLighterColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
