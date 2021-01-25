import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/model/hub.dart';
import 'package:rsn_form/widget/hub_dropdownlist.dart';
import 'package:path/path.dart';

class RsnSettings extends StatefulWidget {
  @override
  _RsnSettingsState createState() => _RsnSettingsState();
}

class _RsnSettingsState extends State<RsnSettings> {
  var map;

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
                ],
              ),
            ),
            body: TabBarView(
              children: [_getHubs(), Text('Test')],
            )));
  }

  FutureBuilder<void> _getHubs() {
    return FutureBuilder<void>(
        future: getResources(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  HubDropdownlist(map),
                ]);
          }
        });
  }

  Future<void> getResources() async {
    map = Map<String, dynamic>();
    IAppConfDao dao = GetIt.I.get<IAppConfDao>();
    var hubs = await rootBundle.loadString(join('resources', 'hubs.json'));
    await dao.findByKey('ownHub').then((value) {
      if (value != null && value.isNotEmpty) {
        map['ownHub'] = value[0].value;
      } else {
        map['ownHub'] = '';
      }
    });
    map['hubs'] = hubs;
  }
}
