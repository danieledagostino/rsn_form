import 'package:flutter/material.dart';
import 'package:rsn_form/pages/rsn_stepper.dart';

class RadioForm {
  final String question;
  final Map<String, String> values;
  String selectedValue;
  final BuildContext context;

  RadioForm(
      {Key key,
      @required this.question,
      @required this.values,
      @required this.context,
      this.selectedValue});

  List<Widget> getWidgets() {
    List<Widget> list = List<Widget>();

    list.add(Text(question));
    print(values);

    values.forEach((k, v) => list.add(
          RadioListTile<String>(
            title: Text(k),
            value: v,
            groupValue: selectedValue,
            onChanged: (String value) =>
                RsnStepper.of(context).setState(() => selectedValue = value),
          ),
        ));

    return list;
  }
}
