import 'package:mabro/res/colors.dart';
import 'package:flutter/material.dart';

class PCheckboxListTile extends StatelessWidget {
  final bool value;
  final String title;
  final Function onChanged;
  final Color selectedColor;
  final Color color;
  final IconData icon;

  const PCheckboxListTile(
      {Key key,
      @required this.value,
      @required this.title,
      @required this.onChanged,
      this.selectedColor,
      this.color, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onChanged(),
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontSize: 14)),
      trailing: CircleAvatar(
        backgroundColor: value
            ? selectedColor != null
                ? selectedColor
                : ColorConstants.primaryColor
            : color != null
                ? color
                : ColorConstants.primaryColor,
        radius: 11.0,
        child: CircleAvatar(
          radius: 10.0,
          backgroundColor: value
              ? (selectedColor != null)
                  ? selectedColor
                  : ColorConstants.primaryColor
              : Colors.white,
          child: value
              ? Icon(
                  Icons.check,
                  size: 14.0,
                  color: Colors.white,
                )
              : Icon(
                  Icons.check,
                  size: 14.0,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
