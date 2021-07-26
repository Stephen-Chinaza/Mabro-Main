import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/constants/string_constants/string_constants.dart';
import 'package:mabro/core/models/slider.dart';
import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: Dims.horizontalMargin(),
          child: Text(
            sliderArrayList[index].sliderHeading,
            style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.red[800],
                fontSize: 20,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              sliderArrayList[index].sliderSubHeading,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
              height: 600,
              width: 600,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image:
                          AssetImage(sliderArrayList[index].sliderImageUrl))),
            ),
          ),
        )
      ],
    );
  }
}
