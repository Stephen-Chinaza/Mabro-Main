import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final Color backgroundColorStart, backgroundColorEnd, textColor, iconColor;
  final Function onPressed;
  final double height;

  @override
  final Size preferredSize;

  TopBar({
    @required this.title,
    this.icon,
    this.onPressed,
    this.backgroundColorStart = ColorConstants.primaryColor,
    this.textColor,
    this.iconColor = ColorConstants.secondaryColor,
    this.backgroundColorEnd = Colors.black,
    this.height,
  }) : preferredSize = Size.fromHeight(60.0);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dims.screenWidth(context),
      height: 75,
      decoration: BoxDecoration(
        gradient: ColorConstants.primaryGradient,
      ),
      child: SafeArea(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () => kbackBtn(context),
              child: Container(
                height: Dims.sizedBoxHeight(
                    height: Dims.screenHeight(context) * 0.10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 25,
                  ),
                ),
              )),
          // (widget.icon == null) ? SizedBox(width: 100) : SizedBox(width: 80),
          TextStyles.textHeadings(
              textSize: 16,
              textColor: widget.textColor,
              textValue: widget.title.toUpperCase()),

          Icon(
            widget.icon,
            color: Colors.transparent,
            size: 30,
          ),
        ]),
      ),
    );
  }
}
