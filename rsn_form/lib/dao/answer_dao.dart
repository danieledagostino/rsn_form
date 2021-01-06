import 'package:rsn_form/model/answer.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AnswerDao {
  DatabaseFactory databaseFactory = databaseFactoryIo;
  Database _db; //db declaration
  //specifiy the store folder of this map (database)
  final store = intMapStoreFactory.store('form_answers');

  static final AnswerDao _singleton = AnswerDao._internal();

  AnswerDao._internal();

  factory AnswerDao() {
    return _singleton;
  }

  Future init() async {
    if (_db == null) {
      _opendDatabase().then((db) => _db = db);
    }
  }

  Future _opendDatabase() async {
    //private method
    //getApplicationDocumentsDirectory method from lib path_provider
    final documentsPath = await getApplicationDocumentsDirectory();

    //join from lib path to concatena with the right separator fro the current system
    final dbPath = join(documentsPath.path, 'rsn_form_answers.db');

    //finally open the db
    final db = await databaseFactory.openDatabase(dbPath);
    return db;
  }

  Future insert(Answer answer) async {
    init();
    int id = await store.add(_db, answer.toMap());
    return id;
  }

  Future insertOrUpdate(Answer answer) async {
    init();
    Answer find = await findByStep(answer.step);
    if (find == null) {
      return insert(answer);
    } else {
      return update(answer);
    }
  }

  Future<List<Answer>> findAll() async {
    init();
    final finder = Finder(sortOrders: [SortOrder('step')]);
    final answers = await store.find(_db, finder: finder);
    return answers.map((e) {
      final answer = Answer.fromMap(e.value);
      //art.step = e.key;
      return answer;
    }).toList();
  }

  Future<Answer> findByStep(int step) async {
    init();
    final finder = Finder(
        sortOrders: [SortOrder('step')], filter: Filter.equals('step', step));
    final answers = await store.find(_db, finder: finder);
    List<Answer> list = answers.map((e) {
      final answer = Answer.fromMap(e.value);
      //art.step = e.key;
      return answer;
    }).toList();

    if (list.length > 0) {
      return list.first;
    } else {
      return null;
    }
  }

  Future update(Answer a) async {
    init();
    final finder = Finder(filter: Filter.byKey(a.step));
    await store.update(_db, a.toMap(), finder: finder);
  }

  Future delete(Answer a) async {
    init();
    final finder = Finder(filter: Filter.byKey(a.step));
    await store.delete(_db, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_db);
  }
}
