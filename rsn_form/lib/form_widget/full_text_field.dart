import 'package:flutter/material.dart';
import 'package:rsn_form/form_widget/super_widget.dart';

class RsnFullTextField extends SuperWidget {
  final TextEditingController controller = TextEditingController();

  RsnFullTextField({int step, String question}) : super(step, question);

  @override
  Widget getFormWidget(String value) {
    controller.text = value;
    return TextField(
      maxLines: 5,
      autofocus: true,
      controller: controller,
      onEditingComplete: () {},
    );
  }
}
