import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MaterialColor backgroundColor;
  Function onPressed;
  String label;
  IconData buttonIcon;

  MenuButton(
      {this.backgroundColor, this.buttonIcon, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton.icon(
        disabledColor: Colors.grey[400],
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          buttonIcon,
          color: Colors.white,
        ),
        textColor: Colors.white,
        splashColor: Colors.red,
        color: backgroundColor,
      ),
    );
  }
}
