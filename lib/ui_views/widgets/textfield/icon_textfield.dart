import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconFields extends StatelessWidget {
  final String labelText;
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
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4),
          topLeft: Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: TextField(
                cursorColor: ColorConstants.secondaryColor,
                enabled: isEditable,
                onTap: onTap,
                controller: controller,
                onChanged: onChanged,
                keyboardType: textInputType ?? TextInputType.text,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 16.0),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: ColorConstants.secondaryColor,
                    size: 30,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.lighterSecondaryColor
                            .withOpacity(0.3)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.secondaryColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
