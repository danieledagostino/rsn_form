import 'package:rsn_form/model/app_conf.dart';
import 'dart:async';

abstract class IAppConfDao {
  Future insert(AppConf conf);

  Future insertOrUpdate(AppConf conf);

  Future<List<AppConf>> findAll();

  Future<List<AppConf>> findByKey(String key);

  Future update(AppConf a);

  Future delete(AppConf a);

  Future deleteAll();
}
