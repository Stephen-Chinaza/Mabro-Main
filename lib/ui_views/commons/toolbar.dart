import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  IconData icon;
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
    return Material(
      elevation: 30,
      child: Container(
        width: Dims.screenWidth(context),
        height: 75,
        decoration: BoxDecoration(
          color: ColorConstants.primaryLighterColor,
        ),
        child: SafeArea(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            (widget.icon != null)
                ? GestureDetector(
                    onTap: () => kbackBtn(context),
                    child: Container(
                      height: Dims.sizedBoxHeight(
                          height: Dims.screenHeight(context) * 0.10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          widget.icon,
                          color: ColorConstants.whiteLighterColor,
                          size: 20,
                        ),
                      ),
                    ))
                : SizedBox.shrink(),
            SizedBox(width: 10),
            TextStyles.textDetails(
                textSize: 15,
                textColor: ColorConstants.whiteLighterColor,
                textValue: widget.title),
            Icon(
              widget.icon,
              color: Colors.transparent,
              size: 30,
            ),
          ]),
        ),
      ),
    );
  }
}
