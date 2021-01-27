import 'package:flutter/material.dart';
import 'package:rsn_form/widget/hub_dropdownlist.dart';

class RsnSettings extends StatefulWidget {
  @override
  _RsnSettingsState createState() => _RsnSettingsState();
}

class _RsnSettingsState extends State<RsnSettings> {
  HubDropdownlist _hubList;

  @override
  void initState() {
    _hubList = HubDropdownlist();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: AppBar(
              title: Text('RSN settings'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.account_box)),
                  //Tab(icon: Icon(Icons.alarm_sharp)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _hubList,
                Center(child: Text('Not implemented yet')),
                //Center(child: Text('Not implemented yet'))
              ],
            )));
  }
}
