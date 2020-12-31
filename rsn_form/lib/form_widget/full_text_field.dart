import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';

class FullTextField extends SuperWidget {
  final TextEditingController controller = TextEditingController();

  FullTextField({String question}) : super(question);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    list.add(TextFormField(
      maxLines: 5,
      autofocus: true,
      controller: controller,
    ));
    return Column(children: list);
  }
}
