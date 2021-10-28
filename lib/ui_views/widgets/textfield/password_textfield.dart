import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border:
              Border.all(color: ColorConstants.whiteLighterColor, width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextField(
          obscureText: _obscureText,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          focusNode: widget.myFocusNode,
          onChanged: widget.onChanged,
          cursorColor: ColorConstants.secondaryColor,
          style: TextStyle(color: ColorConstants.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorConstants.primaryColor.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                  color: ColorConstants.whiteColor, width: 1.0),
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
            hintText: widget.textHint,
            prefixIcon: (widget.icon == null)
                ? Container()
                : Icon(
                    widget.icon,
                    color: (widget.iconColor == null)
                        ? ColorConstants.whiteLighterColor
                        : widget.iconColor,
                    size: 22,
                  ),
            hintStyle: TextStyle(
                fontStyle: FontStyle.normal,
                color: ColorConstants.whiteLighterColor,
                fontSize: 16,
                fontWeight: FontWeight.w300),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
            suffixIcon: GestureDetector(
              onTap: _toggleIcon,
              child: Icon(
                _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                size: 15.0,
                color: ColorConstants.whiteLighterColor,
              ),
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
