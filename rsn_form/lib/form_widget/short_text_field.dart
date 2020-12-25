import 'package:flutter/material.dart';

class ShortTextField {
  final TextEditingController controller;
  final String question;

  ShortTextField({Key key, @required this.controller, this.question});

  List<Widget> getWidgets() {
    return <Widget>[
      Text(question),
      TextFormField(
        autofocus: true,
        controller: controller,
      ),
    ];
  }
}
