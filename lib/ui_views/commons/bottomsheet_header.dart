import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  final String buttomSheetTitle;
  const BottomSheetHeader({
    Key key,
    this.buttomSheetTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(gradient: ColorConstants.primaryGradient),
            width: double.infinity,
            height: 55,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.textDetails(
                      textSize: 16,
                      textColor: Colors.white,
                      textValue: buttomSheetTitle.toUpperCase(),
                    ),
                    GestureDetector(
                        onTap: () => kbackBtn(context),
                        child: Icon(Icons.close, color: Colors.white, size: 20))
                  ]),
            )),
        Divider(
          height: 0.5,
          color: Colors.black38,
        ),
      ],
    );
  }
}
