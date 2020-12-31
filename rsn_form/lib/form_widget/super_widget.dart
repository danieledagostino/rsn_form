import 'package:flutter/cupertino.dart';

abstract class SuperWidget extends StatelessWidget {
  String question;

  SuperWidget(this.question);

  List<Widget> getInitialWidgetList() {
    List<Widget> list = List<Widget>();
    if (!question.isEmpty) {
      list.add(Text(question));
    }

    return list;
  }
}
