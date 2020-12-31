import 'package:flutter/material.dart';

class RadioForm extends StatelessWidget {
  final String question;
  final Map<String, String> values;
  ValueNotifier<String> selectedValue = ValueNotifier<String>('');

  RadioForm(
      {Key key,
      @required this.question,
      @required this.values,
      String selectedValue}) {
    this.selectedValue.value = selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      Text(question),
      ListView.builder(
          itemCount: values.length,
          itemBuilder: (context, position) {
            String k = values.keys.toList()[position];
            String v = values.values.toList()[position];
            return ValueListenableBuilder(
                valueListenable: selectedValue,
                builder:
                    (BuildContext context, String newSelect, Widget child) {
                  return RadioListTile(
                      title: Text(k),
                      groupValue: newSelect,
                      onChanged: (value) => update(value),
                      value: v);
                });
          })
    ]));
  }

  void update(String value) {
    selectedValue.value = value;
  }
}
