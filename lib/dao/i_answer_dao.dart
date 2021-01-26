import 'package:rsn_form/model/answer.dart';
import 'dart:async';

abstract class IAnswerDao {
  Future insert(Answer answer);

  Future insertOrUpdate(Answer answer);

  Future<List<Answer>> findAll();

  Future<List<Answer>> findByStep(int step);

  Future update(Answer a);

  Future delete(Answer a);

  Future deleteAll();
}
