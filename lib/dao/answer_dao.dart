import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_answer_dao.dart';
import 'package:rsn_form/model/answer.dart';
import 'dart:async';
import 'package:sembast/sembast.dart';

class AnswerDao extends IAnswerDao {
  final Database _db = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("form_answers");

  @override
  Future insert(Answer answer) async {
    int id = await _store.add(_db, answer.toMap());
    return id;
  }

  @override
  Future insertOrUpdate(Answer answer) async {
    List<Answer> find = await findByStep(answer.step);
    if (find.isEmpty) {
      return insert(answer);
    } else {
      return update(answer);
    }
  }

  @override
  Future<List<Answer>> findAll() async {
    final finder = Finder(sortOrders: [SortOrder('step')]);
    final answers = await _store.find(_db, finder: finder);
    return answers.map((e) {
      final answer = Answer.fromMap(e.value);
      //art.step = e.key;
      return answer;
    }).toList();
  }

  @override
  Future<List<Answer>> findByStep(int step) async {
    if (step != null) {
      final finder = Finder(
          sortOrders: [SortOrder('step')], filter: Filter.equals('step', step));
      final answers = await _store.find(_db, finder: finder);
      return answers.map((e) {
        final answer = Answer.fromMap(e.value);
        //art.step = e.key;
        return answer;
      }).toList();
    } else {
      return List();
    }
  }

  @override
  Future update(Answer a) async {
    final finder = Finder(filter: Filter.equals('step', a.step));
    await _store.update(_db, a.toMap(), finder: finder);
  }

  @override
  Future delete(Answer a) async {
    final finder = Finder(filter: Filter.equals('step', a.step));
    await _store.delete(_db, finder: finder);
  }

  @override
  Future deleteAll() async {
    await _store.delete(_db);
  }
}
