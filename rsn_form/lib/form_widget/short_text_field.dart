import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnShortTextField extends SuperWidget {
  RsnShortTextField({@required int step, String question, String value})
      : super(step, question, value);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> list = getInitialWidgetList();
    controller.text = this.value ?? '';
    list.add(TextFormField(
      autofocus: true,
      controller: controller,
      /*
      onChanged: (v) {
        if (v.length > 5)
          dao.insert(Answer(this.step, this.question, controller.text));
      },
      */
    ));
    return Column(children: list);
  }
}
