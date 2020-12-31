import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class DateField extends StatelessWidget {
  final String question;
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  DateField({Key key, @required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(question),
      ValueListenableBuilder(
          valueListenable: selectedDate,
          builder: (BuildContext context, DateTime newDate, Widget child) {
            return DateTimeField(
              selectedDate: newDate ?? DateTime.now(),
              mode: DateFieldPickerMode.date,
              onDateSelected: (DateTime date) => {update(date)},
              lastDate: DateTime(2021),
            );
          })
    ]);
  }

  void update(DateTime date) {
    selectedDate.value = date;
  }
}
