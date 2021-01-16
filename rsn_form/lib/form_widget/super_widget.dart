import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_answer_dao.dart';
import 'package:rsn_form/model/answer.dart';

abstract class SuperWidget extends StatelessWidget {
  String question;
  int step;
  IAnswerDao dao;

  SuperWidget(this.step, this.question) {
    dao = GetIt.I.get();
  }

  Widget getFormWidget(String value);

  List<Widget> getInitialWidgetList() {
    List<Widget> list = List<Widget>();
    if (question.isNotEmpty) {
      list.add(Text(question));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list;
    return FutureBuilder<List<Answer>>(
        future: dao.findByStep(this.step),
        builder: (BuildContext context, AsyncSnapshot<List<Answer>> snapshot) {
          list = getInitialWidgetList();
          if (snapshot.hasData) {
            debugPrint(snapshot.data.first.toString());
            list.add(getFormWidget(snapshot.data.first.value));
          } else {
            list.add(getFormWidget(''));
          }
          return Column(children: list);
        });
  }
}
