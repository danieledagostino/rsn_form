import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:rsn_form/dao/answer_dao.dart';
import 'package:rsn_form/dao/i_answer_dao.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/dao/app_conf_dao.dart';

class Init {
  static Future<bool> initialize() async {
    await _initSembast();
    _registerRepositories();
    return true;
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "rsn_database.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }

  static _registerRepositories() {
    GetIt.I.registerLazySingleton<IAnswerDao>(() => AnswerDao());
    GetIt.I.registerLazySingleton<IAppConfDao>(() => AppConfDao());
  }
}
