import 'package:mabro/res/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final double height;
  final IconData icon;
  final double margin;
  final double borderRadius;
  final bool disableButton;

  const CustomButton(
      {this.text,
      this.onPressed,
      this.width = double.infinity,
      this.height = 45,
      this.icon,
      this.margin = 8.0,
      this.borderRadius = 3.0,
      this.disableButton = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (!disableButton) ? null : onPressed,
      child: Container(
        margin: EdgeInsets.all(margin),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: (!disableButton)
              ? ColorConstants.disabledGradient
              : ColorConstants.primaryGradient,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                text,
                style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            (icon == null) ? SizedBox(width: 0) : SizedBox(width: 20),
            (icon == null) ? Container() : Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
