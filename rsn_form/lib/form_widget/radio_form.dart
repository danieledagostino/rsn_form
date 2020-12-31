import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';

class RadioForm extends SuperWidget {
  final Map<String, String> values;
  ValueNotifier<String> selectedValue = ValueNotifier<String>('');

  RadioForm({String question, @required this.values, String selectedValue})
      : super(question) {
    this.selectedValue.value = selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    values.forEach((key, value) {
      list.add(ValueListenableBuilder(
          valueListenable: selectedValue,
          builder: (BuildContext context, String newSelect, Widget child) {
            return RadioListTile(
                title: Text(key),
                groupValue: newSelect,
                onChanged: (v) => update(v),
                value: value);
          }));
    });

    return Column(children: list);
  }

  void update(String value) {
    selectedValue.value = value;
  }
}
