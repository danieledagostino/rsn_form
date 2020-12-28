import 'package:flutter/material.dart';

class ShortTextField {
  final String question;

  ShortTextField({Key key, @required this.question});

  List<Widget> getWidgets() {
    return <Widget>[
      Text(question),
      TextField(
        autofocus: true,
        onSubmitted: (t) {
          print('onSubmitted' + t);
        },
      ),
    ];
  }
}
