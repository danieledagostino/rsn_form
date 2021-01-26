import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';
import 'package:rsn_form/model/answer.dart';

class RsnShortTextField extends SuperWidget {
  RsnShortTextField(int step, String title, String question)
      : super(step, title, question);
  TextEditingController controller = TextEditingController();

  @override
  Widget getFormWidget(String value) {
    controller.text = value;
    return TextFormField(
      autofocus: true,
      controller: controller,
      onEditingComplete: () => {},
    );
  }
}
