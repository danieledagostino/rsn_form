import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class DateField extends InheritedWidget {
  final TextEditingController controller = TextEditingController();
  final String question;
  DateTime selectedDate = DateTime.now();
  final BuildContext context;
  DateTimeField child;

  DateField(
      {Key key, this.child, @required this.context, @required this.question})
      : super(key: key, child: child);

  static DateField of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DateField>();
  }

  @override
  bool updateShouldNotify(DateField oldWidget) {
    return oldWidget.child != child;
    //return true;
  }

  List<Widget> getWidgets() {
    return <Widget>[
      Text(question),
      DateTimeField(
        selectedDate: selectedDate,
        mode: DateFieldPickerMode.date,
        onDateSelected: (DateTime date) => {selectedDate = date},
        lastDate: DateTime(2021),
      ),
    ];
  }
}
