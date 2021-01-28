import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/utility/notify.dart';
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

  @override
  void setAlarm({bool formSubmitted: false}) async {
    Duration d;
    var now = new DateTime.now();
    if (formSubmitted) {
      findByKey('alarmKey').then((value) async {
        //if form is submitted then the alarm was set
        //so I delete the current alarm
        final alarmKey = value.first.value;
        AndroidAlarmManager.cancel(alarmKey);
      });
    }

    int alarmDay;

    //get the set alarmDay from the settings
    List<AppConf> conf = await findByKey('alarmDay');
    if (conf.isNotEmpty) {
      alarmDay = conf.first.value;
    } else {
      insertOrUpdate(AppConf('alarmDay', DateTime.friday));
      alarmDay = DateTime.friday;
    }

    if (now.weekday <= alarmDay) {
      if (formSubmitted) {
        //if today is not friday it means that I sent the form for the current week
        //I need to set the alarm for the next friday past this week
        d = Duration(days: ((alarmDay - now.weekday) + 7), minutes: 5);
      } else {
        d = Duration(days: alarmDay - now.weekday, minutes: 5);
      }
    } else {
      //if today is equal to friday or greater than (sat or sun)
      //it means I need to set alarm for the next coming friday
      d = Duration(days: 7 - now.weekday + alarmDay, minutes: 5);
    }

    final alarmKey = Random().nextInt(pow(2, 31));
    await AndroidAlarmManager.oneShot(d, alarmKey, Notify.setAlarm,
            exact: true,
            wakeup: true,
            rescheduleOnReboot: true,
            alarmClock: true)
        .then((value) {
      insertOrUpdate(AppConf('alarmKey', alarmKey));
    });
  }
}
