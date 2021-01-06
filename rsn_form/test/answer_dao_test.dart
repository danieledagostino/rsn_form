import 'package:rsn_form/dao/answer_dao.dart';
import 'package:rsn_form/model/answer.dart';
import 'package:test/test.dart';

void main() {
  test('dao insert and read', () async {
    int step = 432432;
    String questionTest = 'Question test 1';

    AnswerDao dao = AnswerDao();

    Answer toInsert = Answer(step, questionTest, 'Response 1');

    Future res = await dao.insert(toInsert);
    res.then((value) => {expect(true, value > 0)});

    dao.findByStep(step).then((value) {
      expect(questionTest, value.question);
      print(value);
    });
  });
}
