import 'package:rsn_form/model/answer.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

abstract class IAnswerDao {
  Future insert(Answer answer);

  Future insertOrUpdate(Answer answer);

  Future<List<Answer>> findAll();

  Future<List<Answer>> findByStep(int step);

  Future update(Answer a);

  Future delete(Answer a);

  Future deleteAll();
}
