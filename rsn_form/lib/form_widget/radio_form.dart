import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnRadioField extends SuperWidget {
  final Map<String, String> values;
  ValueNotifier<String> selectedValue = ValueNotifier<String>('');

  RsnRadioField({int step, String question, @required this.values})
      : super(step, question);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    this.dao.findByStep(this.step).then((Answer answer) {
      selectedValue.value = answer.value;
    });
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
    dao.insertOrUpdate(Answer(this.step, this.question, value));
  }
}
