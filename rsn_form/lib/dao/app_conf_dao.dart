import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:rsn_form/model/app_conf.dart';

class AppConfDao extends IAppConfDao {
  final Database _db = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("app_conf");

  @override
  Future insert(AppConf conf) async {
    int id = await _store.add(_db, conf.toMap());
    return id;
  }

  @override
  Future insertOrUpdate(AppConf conf) async {
    List<AppConf> find = await findByKey(conf.key);
    if (find.isEmpty) {
      return insert(conf);
    } else {
      return update(conf);
    }
  }

  @override
  Future<List<AppConf>> findAll() async {
    final finder = Finder(sortOrders: [SortOrder('key')]);
    final confs = await _store.find(_db, finder: finder);
    return confs.map((e) {
      final conf = AppConf.fromMap(e.value);
      //art.step = e.key;
      return conf;
    }).toList();
  }

  @override
  Future<List<AppConf>> findByKey(String key) async {
    if (key != null) {
      final finder = Finder(
          sortOrders: [SortOrder('step')], filter: Filter.equals('key', key));
      final confs = await _store.find(_db, finder: finder);
      return confs.map((e) {
        final conf = AppConf.fromMap(e.value);
        //art.step = e.key;
        return conf;
      }).toList();
    } else {
      return List();
    }
  }

  @override
  Future update(AppConf conf) async {
    final finder = Finder(filter: Filter.equals('key', conf.key));
    await _store.update(_db, conf.toMap(), finder: finder);
  }

  @override
  Future delete(AppConf conf) async {
    final finder = Finder(filter: Filter.equals('key', conf.key));
    await _store.delete(_db, finder: finder);
  }

  @override
  Future deleteAll() async {
    await _store.delete(_db);
  }
}
