import 'package:flutter/material.dart';

class RadioForm {
  final TextEditingController controller;
  final String question;
  final Map<String, String> values;
  String selectedValue;

  RadioForm(
      {Key key,
      @required this.controller,
      @required this.question,
      @required this.values,
      this.selectedValue});

  List<Widget> getWidgets() {
    List<Widget> list = List<Widget>();

    list.add(Text(question));

    values.forEach((key, v) => () {
          list.add(
            RadioListTile<String>(
              title: Text(key),
              value: v,
              groupValue: selectedValue,
              onChanged: (String value) {
                selectedValue = value;
              },
            ),
          );
        });

    return list;
  }
}
