import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnDateTimeField extends SuperWidget {
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  RsnDateTimeField({int step, String question}) : super(step, question) {}

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    this.dao.findByStep(this.step).then((Answer answer) {
      selectedDate.value = DateTime.parse(answer.value);
    });
    list.add(ValueListenableBuilder(
        valueListenable: selectedDate,
        builder: (BuildContext context, DateTime newDate, Widget child) {
          return DateTimeField(
            selectedDate: newDate ?? DateTime.now(),
            mode: DateFieldPickerMode.dateAndTime,
            onDateSelected: (DateTime date) => {update(date)},
            lastDate: DateTime(2022),
          );
        }));
    return Column(children: list);
  }

  void update(DateTime date) {
    selectedDate.value = date;
    dao.insertOrUpdate(Answer(this.step, this.question, date.toString()));
  }
}
