import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatefulWidget {
  final String labelText;
  final String textHint;
  final IconData icon;
  final Color iconColor;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FocusNode myFocusNode;
  final Function onChanged;
  final bool isEditable;
  final double radius;
  final double elevation;
  final double padding;

  PasswordTextField({
    Key key,
    this.textHint,
    this.icon,
    this.iconColor,
    this.textInputType,
    this.controller,
    this.labelText,
    this.onChanged,
    this.isEditable = true,
    this.myFocusNode,
    this.radius = 4,
    this.elevation = 3,
    this.padding = 16.0,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
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
      child: TextField(
        obscureText: _obscureText,
        keyboardType: widget.textInputType,
        controller: widget.controller,
        focusNode: widget.myFocusNode,
        onChanged: widget.onChanged,
        cursorColor: ColorConstants.secondaryColor,
        decoration: InputDecoration(
          hintText: widget.textHint,
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.lighterSecondaryColor.withOpacity(0.3)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.secondaryColor),
          ),
          prefixIcon: (widget.icon == null)
              ? Container()
              : Icon(
                  widget.icon,
                  color: (widget.iconColor == null)
                      ? ColorConstants.primaryColor
                      : widget.iconColor,
                ),
          hintStyle: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black38,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
          suffixIcon: GestureDetector(
            onTap: _toggleIcon,
            child: Icon(
              _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _toggleIcon() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
