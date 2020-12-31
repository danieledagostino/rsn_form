import 'package:flutter/material.dart';

class ShortTextField extends StatelessWidget {
  final String question;

  ShortTextField({Key key, @required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(question),
      TextField(
        autofocus: true,
        onSubmitted: (t) {
          print('onSubmitted' + t);
        },
      ),
    ]);
  }
}
