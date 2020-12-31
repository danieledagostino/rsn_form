import 'package:flutter/material.dart';

class FullTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String question;

  FullTextField({Key key, @required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(question),
      TextFormField(
        maxLines: 5,
        autofocus: true,
        controller: controller,
      ),
    ]);
  }
}
