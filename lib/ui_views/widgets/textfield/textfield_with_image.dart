import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageFields extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String image;
  final Function onChanged;
  final double width;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Color bgColor;
  final bool isEditable;

  const ImageFields(
      {@required this.labelText,
      this.hintText,
      this.onChanged,
      this.controller,
      this.onTap,
      this.textInputType,
      this.isEditable = true,
      this.width, this.bgColor = Colors.white, this.image = 'assets/images/btc.jpg'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: ColorConstants.primaryColor,
                    enabled: isEditable,
                    onTap: onTap,
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: textInputType ?? TextInputType.text,
                    style:  TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                                  hintText: hintText,
                                  hintStyle: TextStyle(
                                      color: Colors.black38, fontSize: 16.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorConstants.lighterSecondaryColor.withOpacity(0.3)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.secondaryColor),
                      ),
                                ),
                  ),
                ),
              ),
              Image.asset(image, height: 50, width: 60,fit: BoxFit.cover,),
            ],
          ),
        ),
      ],
    );
  }
}
