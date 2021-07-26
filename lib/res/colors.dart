import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class ColorConstants {
  const ColorConstants();

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  static const Color secondaryColor = Color(0xFF27133a);
  static const Color primaryColor = Color(0xFF27133a);
  //static const Color primaryColor = Color(0xFFfa1e0e);
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF8c8c8c);
  static const Color lightSecondaryColor = Color(0xFFF2f1c41);
  static const Color lighterSecondaryColor = Color(0xFFF3f2d4f);
  static Color transparent = Colors.transparent;
  static Color lightBlue2 = Colors.white.withOpacity(0.4);
  static Color lightBlue1 = Colors.white.withOpacity(0.2);
  static Color yellow = Colors.white.withOpacity(0.4);
  static Color yellow2 = Colors.white.withOpacity(0.2);

  static const primaryGradient = const LinearGradient(
    colors: const [primaryColor, secondaryColor],
    begin: const FractionalOffset(0.2, 0.2),
    end: const FractionalOffset(1.0, 0.1),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
  );

  static const disabledGradient = const LinearGradient(
    colors: const [grey, grey],
    begin: const FractionalOffset(0.2, 0.2),
    end: const FractionalOffset(1.0, 1.0),
    stops: [0.0, 0.5],
    tileMode: TileMode.clamp,
  );
}
