import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';

class ShortTextField extends SuperWidget {
  ShortTextField({String question}) : super(question);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    list.add(TextField(
      autofocus: true,
      onSubmitted: (t) {
        print('onSubmitted' + t);
      },
    ));
    return Column(children: list);
  }
}
