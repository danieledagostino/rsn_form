import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/answer_dao.dart';
import 'package:rsn_form/dao/init.dart';
import 'package:rsn_form/model/answer.dart';
import 'package:test/test.dart';

void main() {
  test('dao insert and read', () async {
    int step = 432432;
    String title = "Title test";
    String questionTest = 'Question test 1';

    AnswerDao dao = AnswerDao();
    dao.deleteAll();

    Answer toInsert = Answer(step, title, questionTest, 'Response 1');

    Future res = await dao.insert(toInsert);
    res.then((value) => {expect(true, value > 0)});

    dao.findByStep(step).then((value) {
      expect(questionTest, value.first.question);
      print(value);
    });
  });

  test('launch deleteAll to clean db', () {
    AnswerDao dao = AnswerDao();
    dao.deleteAll();
  });

  test('print all sembast store', () async {
    AnswerDao dao = AnswerDao();
    dao.findAll().then((value) {
      value.forEach((element) => debugPrint(element.toString()));
    });
  });

  test('get specific step from store', () async {
    AnswerDao dao;
    Init.initialize().then((value) => dao = GetIt.I.get());
    dao.findByStep(1).then((value) {
      value.forEach((element) => debugPrint(element.toString()));
    });
  });
}
