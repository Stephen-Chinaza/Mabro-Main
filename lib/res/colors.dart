import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class ColorConstants {
  const ColorConstants();


  static const Color secondaryColor = Color(0xFFFF4961);
  static const Color primaryColor = Color(0xFF05031A);
  static const Color primaryLighterColor = Color(0xFF14112E);
  static const Color whiteLighterColor = Color(0xFF7E7E7E);
  static const Color whiteColor = Color(0xFFFAFAFB);
  static const Color orangeColor = Color(0xFFAC4CBC);

  static const Color scaffoldBackgroundColor = Color(0xFF05031A);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF8c8c8c);
  static const Color lightSecondaryColor = Color(0xFF26143A);
  static const Color lighterSecondaryColor = Color(0xFFF3f2d4f);
  static Color transparent = Colors.transparent;
  static Color lightBlue2 = Colors.white.withOpacity(0.4);
  static Color lightBlue1 = Colors.white.withOpacity(0.2);
  static Color yellow = Colors.white.withOpacity(0.4);
  static Color yellow2 = Colors.white.withOpacity(0.2);

  static const primaryGradient = const LinearGradient(
    colors: const [secondaryColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.clamp,
  );

  static const primaryGradient1 = const LinearGradient(
    colors: const [primaryColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.clamp,
  );

  static const primaryGradient2 = const LinearGradient(
    colors: const [secondaryColor, primaryColor],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: TileMode.clamp,
  );

  static const disabledGradient = const LinearGradient(
    colors: const [whiteLighterColor, whiteLighterColor],
    begin: const FractionalOffset(0.2, 0.2),
    end: const FractionalOffset(1.0, 1.0),
    stops: [0.0, 0.5],
    tileMode: TileMode.clamp,
  );
}
