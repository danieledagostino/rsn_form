import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/model/app_conf.dart';
import 'package:rsn_form/model/hub.dart';

import 'package:path/path.dart';
import 'package:flutter/services.dart';

class HubDropdownlist extends StatelessWidget {
  ValueNotifier<String> selectedValue = ValueNotifier<String>('');
  List<Hub> _hubs;
  String value;

  Future<List<Hub>> _getHubList() async {
    List<Hub> hubs = List<Hub>();
    Map map = await _getResources();
    map.forEach((key, value) {
      if (key == 'hubs') {
        hubs = json.decode(value).map<Hub>((v) {
          return Hub.fromMap(v);
        }).toList();
      } else if (key == 'ownHub' && !(value is String)) {
        Hub h = value as Hub;
        selectedValue.value = h.key.toString();
      }
    });
    return hubs;
  }

  Future<Map> _getResources() async {
    Map map = Map<String, dynamic>();
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

    return map;
  }

  List<Widget> _getList(List<Hub> hubs) {
    List<Widget> list = List<Widget>();
    hubs.forEach((e) {
      list.add(ValueListenableBuilder(
          valueListenable: selectedValue,
          builder: (BuildContext context, String newSelect, Widget child) {
            return RadioListTile(
                title: Text(e.name),
                groupValue: newSelect,
                onChanged: (v) => update(v),
                value: e.key.toString());
          }));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hub>>(
        future: _getHubList(),
        builder: (BuildContext context, AsyncSnapshot<List<Hub>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            _hubs = snapshot.data;

            List<Widget> list = _getList(_hubs);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: list);
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
        });
  }

  void update(String newValue) {
    selectedValue.value = newValue;
    Hub hub;
    for (Hub h in _hubs) {
      if (h.key.toString() == newValue) {
        GetIt.I.get<IAppConfDao>().insertOrUpdate(AppConf('ownHub', h));
        break;
      }
    }
  }
}
