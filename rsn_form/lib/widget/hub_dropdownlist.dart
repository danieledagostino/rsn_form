import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rsn_form/model/hub.dart';

class HubDropdownlist extends StatelessWidget {
  ValueNotifier<String> dropdownValue = ValueNotifier<String>('0');
  List<DropdownMenuItem<String>> items;

  HubDropdownlist(String jsonData) {
    items = List<DropdownMenuItem<String>>();
    List<Hub> hubs = json.decode(jsonData).map<Hub>((v) {
      return Hub.fromMap(v);
    }).toList();

    for (Hub h in hubs) {
      items.add(DropdownMenuItem<String>(
        value: h.key.toString(),
        child: Text(h.name),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: dropdownValue,
        builder: (BuildContext context, String newValue, Widget child) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.amber,
                border: Border.all(
                    color: Colors.amber, style: BorderStyle.solid, width: 0.80),
              ),
              child: DropdownButtonFormField<String>(
                value: newValue,
                isExpanded: true,
                validator: (value) =>
                    value == 0 ? 'Please choose your hub' : null,
                hint: Text('Select your hub'),
                icon: Icon(
                  Icons.house,
                  color: Colors.white,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                onChanged: (String newValue) => update(newValue),
                items: items,
              ));
        });
  }

  void update(String newValue) {
    dropdownValue.value = newValue;
  }
}
