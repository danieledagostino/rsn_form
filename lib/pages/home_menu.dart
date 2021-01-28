import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/pages/rsn_app_bar.dart';
import 'package:rsn_form/pages/rsn_drawer.dart';
import 'package:rsn_form/widget/rsn_feed_widget.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  void initState() {
    AndroidAlarmManager.initialize();
    GetIt.I.get<IAppConfDao>().setAlarm();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: RsnAppBar('RSN'),
        drawer: RsnDrawer(),
        body: Container(
          decoration: BoxDecoration(
              /*
            image: DecorationImage(
              image: AssetImage("resources/background.png"),
              fit: BoxFit.cover,
            ),
            */
              ),
          child: RsnFeedWidget(),
        ));
  }
}
