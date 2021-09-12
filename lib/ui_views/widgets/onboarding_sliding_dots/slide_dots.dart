import 'package:mabro/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
  
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.2),
      height: isActive ? 13 : 5,
      width: isActive ? 13 : 5,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        border: isActive ?  Border.all(color: ColorConstants.secondaryColor,width: 5.0,) :
        Border.all(color: Colors.transparent,width: 5,),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
