import 'package:flutter/material.dart';

class FullTextField {
  final TextEditingController controller;
  final String question;

  FullTextField({Key key, @required this.controller, this.question});

  List<Widget> getWidgets() {
    return <Widget>[
      Text(question),
      TextFormField(
        maxLines: 5,
        autofocus: true,
        controller: controller,
      ),
    ];
  }
}
