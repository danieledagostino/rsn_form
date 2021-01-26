import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/model/app_conf.dart';
import 'package:rsn_form/model/hub.dart';

class HubDropdownlist extends StatelessWidget {
  ValueNotifier<String> selectedValue = ValueNotifier<String>('');
  List<Hub> hubs;
  String value;

  HubDropdownlist(Map map) {
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
  }

  @override
  Widget build(BuildContext context) {
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

    return Column(children: list);
  }

  void update(String newValue) {
    selectedValue.value = newValue;
    Hub hub;
    for (Hub h in hubs) {
      if (h.key.toString() == newValue) {
        GetIt.I.get<IAppConfDao>().insert(AppConf('ownHub', h));
        break;
      }
    }
  }
}
