import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;

  const CustomText({Key key, this.color, this.text, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _texts(
      color: color,
      size: size,
      text: text,
    );
  }

  Text _texts({String text, Color color, double size}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: size),
    );
  }
}
