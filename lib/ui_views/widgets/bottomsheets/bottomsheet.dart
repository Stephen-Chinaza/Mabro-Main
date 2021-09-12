import 'package:mabro/constants/dimes/dimensions.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PersistentBottomSheetController buildShowBottomSheet(
    {@required BuildContext context, Widget bottomsheetContent}) {
  
  return showBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              height: Dims.screenHeight(context),
              width: MediaQuery.of(context).size.width,
              child: bottomsheetContent,
            ),
          ));
}
