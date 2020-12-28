import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:rsn_form/pages/rsn_stepper.dart';

class DateField {
  final TextEditingController controller = TextEditingController();
  final String question;
  DateTime selectedDate = DateTime.now();
  final BuildContext context;

  DateField({Key key, @required this.context, @required this.question});

  List<Widget> getWidgets() {
    return <Widget>[
      Text(question),
      DateTimeField(
        selectedDate: selectedDate,
        mode: DateFieldPickerMode.date,
        onDateSelected: (DateTime date) =>
            RsnStepper.of(context).setState(() => selectedDate = date),
        lastDate: DateTime(2021),
      ),
    ];
  }
}
