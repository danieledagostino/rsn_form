import 'package:flutter/cupertino.dart';
import 'package:rsn_form/dao/answer_dao.dart';

abstract class SuperWidget extends StatelessWidget {
  String question;
  int step;
  String value;
  AnswerDao dao;

  SuperWidget(this.step, this.question, this.value) {
    dao = AnswerDao();
  }

  List<Widget> getInitialWidgetList() {
    List<Widget> list = List<Widget>();
    if (!question.isEmpty) {
      list.add(Text(question));
    }

    return list;
  }
}
