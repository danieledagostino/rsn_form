import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnDateField extends SuperWidget {
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  RsnDateField(int step, String title, String question)
      : super(step, title, question);

  @override
  Widget getFormWidget(String value) {
    if (value.isNotEmpty) {
      selectedDate.value = DateTime.parse(value);
    }
    return ValueListenableBuilder(
        valueListenable: selectedDate,
        builder: (BuildContext context, DateTime newDate, Widget child) {
          return DateTimeField(
            selectedDate: newDate ?? DateTime.now(),
            mode: DateFieldPickerMode.date,
            onDateSelected: (DateTime date) => {update(date)},
            lastDate: DateTime.now().add(Duration(days: 1)),
          );
        });
  }

  void update(DateTime date) {
    selectedDate.value = date;
    dao.insertOrUpdate(
        Answer(this.step, this.title, this.question, date.toString()));
  }
}
