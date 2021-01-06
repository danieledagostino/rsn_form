import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnFullTextField extends SuperWidget {
  final TextEditingController controller = TextEditingController();

  RsnFullTextField({int step, String question, String value})
      : super(step, question, value);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    list.add(TextField(
      maxLines: 5,
      autofocus: true,
      controller: controller,
      onEditingComplete: () {
        dao.insert(Answer(this.step, this.question, controller.text));
      },
      onChanged: (value) {
        dao.insert(Answer(this.step, this.question, controller.text));
      },
    ));
    return Column(children: list);
  }
}
