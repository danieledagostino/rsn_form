import 'package:flutter/material.dart';

class FullTextField {
  final TextEditingController controller = TextEditingController();
  final String question;

  FullTextField({Key key, @required this.question});

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
