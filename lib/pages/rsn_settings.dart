import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/widget/hub_dropdownlist.dart';
import 'package:rsn_form/widget/weekday_alarm_dropdownlist.dart';

class RsnSettings extends StatefulWidget {
  @override
  _RsnSettingsState createState() => _RsnSettingsState();
}

class _RsnSettingsState extends State<RsnSettings>
    with SingleTickerProviderStateMixin {
  HubDropdownlist _hubList;
  WeekdayAlarmDropdownlist _weekdayList;
  TabController _tabController;
  BuildContext _ctx;

  @override
  void initState() {
    _hubList = HubDropdownlist();
    _weekdayList = WeekdayAlarmDropdownlist();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );
    _tabController.addListener(_tabChange);
  }

  void _tabChange() {
    if (_tabController.indexIsChanging &&
        _tabController.index != 2 &&
        _weekdayList.alarmUpdate) {
      _weekdayList.alarmUpdate = false;
      GetIt.I.get<IAppConfDao>().setAlarm();
      //Scaffold.of(_ctx).showSnackBar(SnackBar(content: Text('New alarm set!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
            appBar: AppBar(
              title: Text('RSN settings'),
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.account_box)),
                  Tab(icon: Icon(Icons.alarm_sharp)),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                _hubList,
                Center(child: Text('Not implemented yet')),
                _weekdayList
              ],
            )));
  }
}
