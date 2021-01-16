import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnDateTimeField extends SuperWidget {
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  RsnDateTimeField({int step, String question}) : super(step, question);

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
            mode: DateFieldPickerMode.dateAndTime,
            onDateSelected: (DateTime date) => {update(date)},
            lastDate: DateTime(2022),
          );
        });
  }

  void update(DateTime date) {
    selectedDate.value = date;
    dao.insertOrUpdate(Answer(this.step, this.question, date.toString()));
  }
}
